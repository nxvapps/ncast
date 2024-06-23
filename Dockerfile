ARG CUDA_VERSION
ARG UBUNTU_VERSION
ARG BASE_IMAGE=nvidia/cuda:${CUDA_VERSION}-devel-ubuntu${UBUNTU_VERSION}
FROM ${BASE_IMAGE} AS base

# Install requirements
RUN apt update && \
	apt install -y curl software-properties-common

# Install repos
RUN curl -fsSL https://xpra.org/xpra.asc > /usr/share/keyrings/xpra.asc && \
    echo 'deb [arch=amd64,arm64 signed-by=/usr/share/keyrings/xpra.asc] https://xpra.org jammy main' > /etc/apt/sources.list.d/xpra.list
RUN add-apt-repository -y ppa:obsproject/obs-studio && \
    apt update

# Install packages
RUN echo "keyboard-configuration keyboard-configuration/layoutcode select us" | debconf-set-selections && \
	echo "keyboard-configuration keyboard-configuration/xkb-keymap select us" | debconf-set-selections && \
	apt install -y  \
		breeze-icon-theme \
		brotli \
		dbus-x11 \
		dolphin \
		fail2ban \
		pulseaudio \
		python3-xdg \
		qt5ct \
		tilix \
		vlc \
		xinit \
		xpra \
		xpra-codecs-nvidia \
		xpra-html5 \
		xpra-x11 \
		xserver-xorg-core \
		xserver-xorg-legacy \
		obs-studio

# Remove bundled apps
RUN apt remove -y \
	gnome-terminal \
	tmux \
	xterm

# Setup environment
RUN mkdir -p /run/xpra/ /root/.config/qt5ct /data

# Configure dolphin
RUN echo "export QT_QPA_PLATFORMTHEME=qt5ct" >> "/root/.bash_profile"

# Install VirtualGL
ARG VIRTUALGL_VERSION
ENV VIRTUALGL_VERSION=${VIRTUALGL_VERSION}
RUN curl -fsSL --output virtualgl.deb "https://github.com/VirtualGL/virtualgl/releases/download/${VIRTUALGL_VERSION}/virtualgl_${VIRTUALGL_VERSION}_amd64.deb" && \
    apt install -y ./virtualgl.deb && \
    rm -f ./virtualgl.deb

# Fix Themeing
COPY files/xpra.css /tmp/xpra.css
RUN ln -s /usr/share/xpra/icons/browser.png /usr/share/xpra/icons/Internet.png && \
ln -s /usr/share/xpra/icons/video.png /usr/share/xpra/icons/Multimedia.png && \
ln -s /usr/share/xpra/icons/display.png /usr/share/xpra/icons/Graphics.png && \
ln -s /usr/share/xpra/icons/toolbox.png /usr/share/xpra/icons/Settingsmenu.png && \
ln -s /usr/share/xpra/icons/linux.png /usr/share/xpra/icons/System.png && \
ln -s /usr/share/xpra/icons/features.png /usr/share/xpra/icons/Utilities.png && \
sed -i 's|hicolor|breeze|g' /usr/lib/python3/dist-packages/xdg/Config.py && \
cat /tmp/xpra.css >> /usr/share/xpra/www/css/client.css && \
rm -f /tmp/xpra.css && \
rm -rf /usr/share/xpra/www/css/client.css.br /usr/share/xpra/www/css/client.css.gz && \
brotli /usr/share/xpra/www/css/client.css && \
gzip -k /usr/share/xpra/www/css/client.css

# Fix X11
RUN echo "allowed_users=anybody" > /etc/X11/Xwrapper.config

# Enable services
RUN systemctl enable fail2ban

# Transfer files
COPY files/root-files /root/root-files
RUN cp -rf /root/root-files/* / && \
	rm -rf /root/root-files
