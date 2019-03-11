Return-Path: <SRS0=FxTY=RO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 642F6C10F06
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 13:25:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1571E2084F
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 13:25:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728162AbfCKNZx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Mar 2019 09:25:53 -0400
Received: from mout.kundenserver.de ([212.227.17.24]:51293 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727587AbfCKNTi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Mar 2019 09:19:38 -0400
Received: from orion.localdomain ([95.115.159.19]) by mrelayeu.kundenserver.de
 (mreue109 [212.227.15.183]) with ESMTPSA (Nemesis) id
 1MIxBc-1hMWeT0qxm-00KTR3 for <linux-kernel@vger.kernel.org>; Mon, 11 Mar 2019
 14:19:35 +0100
From:   "Enrico Weigelt, metux IT consult" <info@metux.net>
To:     linux-kernel@vger.kernel.org
Subject: [PATCH 058/114] drivers: net: Kconfig: pedantic formatting
Date:   Mon, 11 Mar 2019 14:18:10 +0100
Message-Id: <1552310346-7629-59-git-send-email-info@metux.net>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1552310346-7629-1-git-send-email-info@metux.net>
References: <1552310346-7629-1-git-send-email-info@metux.net>
X-Provags-ID: V03:K1:1jIy7OKl+QKaqR6GZqcRe97umjlFLkXyEnMCOvRnf0qUSnwdU8P
 x95p/zN4w+aBtovovP+f2vfJjCm1flYOwM+EC9iVRULgsttmSiTC9TkvoDK7N2mhAUvkehM
 d+BBUCCQBEDWReSDtQR0G+Bl6Duoa0O/wSKE43jKpd7DI0rbVWoYgOxRcNMYPDMSRfzTz4t
 9ZCnnnx5wI6YxZCQfQ71g==
X-UI-Out-Filterresults: notjunk:1;V03:K0:xHi/iLXBWT4=:7R6HGqTeKEwGmy0FbMVGYs
 juu5Nkr3+kQocXGvGzcXHRiCl1TK8gfOdWsdDpTkPbif/UlxyoH1ibCQfiK16DhpPAWQrnsXv
 OWfuZVXQNKd+SdhRBnn5VelDm01qkAuC+XeN6DKx9il1gVNHrX5VRQ2ZthecavhRCiDsrBPBJ
 rhJKhoxDO4R9qhtZUvzqm23lnXT/xY+rrdgPOel2PYXNhqjJ0+DVMSTE6zxw2I8mSXSP8+QC2
 jJIksiB4GSX01ZwM65Jstjx7oy71DNx/eB0azTI8kT5mpE3Ivts0EvfP0a53cdyb5qajAcAfD
 yoehx+VGLcLFff0yogtM6vhML740sDNeY4InvvtwAHx78dohVd9XhfE6MibblXVYFpa3mkli6
 3YOBkmHmg3l7NsouC+Sl9Rj830d0k4Po3tWLJlz+lZfZwV1Y3ZfHEdDSWh5kgpvf8fjYSQa+3
 shCXsP5+3QgoINopV94SJXGhNEsPuqSezQRvSCi43RKnCb4Z8Vs+WSaYDhcg/xARTdgY8+gWy
 Oc08Qc+kllcj5eVNwibnZ0GmgNnmPJ387CxOCxfM53ib4HfVrc2v+d+M9pK9K1VNbm/8Lds4L
 mK37jOIdWigUXdix+/wASLsU88hGqY5CBTr6N+NhVTzdTLzmFjpYyYsMgVPZnZvBuIpv6Rwwh
 5pcuYIfcH/3qFiKlvV0wFBAdG8YadzmLeXDKpqHkY3bZuUU4S3yvjhuLSCKWi+dKz6FdibkW/
 xnOfx5hEacwmbz+qCV8PF/pTEYwnnslpcZT54Q==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Formatting of Kconfig files doesn't look so pretty, so let the
Great White Handkerchief come around and clean it up.

Signed-off-by: Enrico Weigelt, metux IT consult <info@metux.net>
---
 drivers/net/Kconfig                             |  64 ++++++-------
 drivers/net/appletalk/Kconfig                   |   1 -
 drivers/net/arcnet/Kconfig                      |  26 ++---
 drivers/net/caif/Kconfig                        |  36 +++----
 drivers/net/can/usb/Kconfig                     |   8 +-
 drivers/net/ethernet/allwinner/Kconfig          |  10 +-
 drivers/net/ethernet/aurora/Kconfig             |   2 +-
 drivers/net/ethernet/dec/tulip/Kconfig          |   6 +-
 drivers/net/ethernet/emulex/benet/Kconfig       |   2 +-
 drivers/net/ethernet/freescale/fs_enet/Kconfig  |   8 +-
 drivers/net/ethernet/intel/Kconfig              |   6 +-
 drivers/net/ethernet/marvell/Kconfig            |   9 +-
 drivers/net/ethernet/mellanox/mlx5/core/Kconfig |  36 +++----
 drivers/net/ethernet/mellanox/mlxsw/Kconfig     |   4 +-
 drivers/net/ethernet/microchip/Kconfig          |  12 +--
 drivers/net/ethernet/nxp/Kconfig                |   8 +-
 drivers/net/hamradio/Kconfig                    |   1 -
 drivers/net/ieee802154/Kconfig                  |  12 +--
 drivers/net/phy/Kconfig                         |   6 +-
 drivers/net/usb/Kconfig                         |  10 +-
 drivers/net/wan/Kconfig                         |   4 +-
 drivers/net/wireless/ath/Kconfig                |  12 +--
 drivers/net/wireless/ath/ar5523/Kconfig         |  14 +--
 drivers/net/wireless/ath/ath9k/Kconfig          |  45 ++++-----
 drivers/net/wireless/ath/carl9170/Kconfig       |   6 +-
 drivers/net/wireless/atmel/Kconfig              |  54 +++++------
 drivers/net/wireless/intel/ipw2x00/Kconfig      | 120 ++++++++++++------------
 drivers/net/wireless/intel/iwlegacy/Kconfig     |   6 +-
 drivers/net/wireless/intel/iwlwifi/Kconfig      |  31 +++---
 drivers/net/wireless/intersil/p54/Kconfig       |  16 ++--
 drivers/net/wireless/ralink/rt2x00/Kconfig      |  47 +++++-----
 drivers/net/wireless/rsi/Kconfig                |   4 +-
 drivers/net/wireless/ti/wl12xx/Kconfig          |   8 +-
 33 files changed, 316 insertions(+), 318 deletions(-)

diff --git a/drivers/net/Kconfig b/drivers/net/Kconfig
index 5e4ca08..77c8caf 100644
--- a/drivers/net/Kconfig
+++ b/drivers/net/Kconfig
@@ -152,22 +152,22 @@ config IPVLAN_L3S
 	select NET_L3_MASTER_DEV
 
 config IPVLAN
-    tristate "IP-VLAN support"
-    depends on INET
-    depends on IPV6 || !IPV6
-    ---help---
-      This allows one to create virtual devices off of a main interface
-      and packets will be delivered based on the dest L3 (IPv6/IPv4 addr)
-      on packets. All interfaces (including the main interface) share L2
-      making it transparent to the connected L2 switch.
+	tristate "IP-VLAN support"
+	depends on INET
+	depends on IPV6 || !IPV6
+	---help---
+	  This allows one to create virtual devices off of a main interface
+	  and packets will be delivered based on the dest L3 (IPv6/IPv4 addr)
+	  on packets. All interfaces (including the main interface) share L2
+	  making it transparent to the connected L2 switch.
 
-      Ipvlan devices can be added using the "ip" command from the
-      iproute2 package starting with the iproute2-3.19 release:
+	  Ipvlan devices can be added using the "ip" command from the
+	  iproute2 package starting with the iproute2-3.19 release:
 
-      "ip link add link <main-dev> [ NAME ] type ipvlan"
+	  "ip link add link <main-dev> [ NAME ] type ipvlan"
 
-      To compile this driver as a module, choose M here: the module
-      will be called ipvlan.
+	  To compile this driver as a module, choose M here: the module
+	  will be called ipvlan.
 
 config IPVTAP
 	tristate "IP-VLAN based tap driver"
@@ -184,11 +184,11 @@ config IPVTAP
 	  will be called ipvtap.
 
 config VXLAN
-       tristate "Virtual eXtensible Local Area Network (VXLAN)"
-       depends on INET
-       select NET_UDP_TUNNEL
-       select GRO_CELLS
-       ---help---
+	tristate "Virtual eXtensible Local Area Network (VXLAN)"
+	depends on INET
+	select NET_UDP_TUNNEL
+	select GRO_CELLS
+	---help---
 	  This allows one to create vxlan virtual interfaces that provide
 	  Layer 2 Networks over Layer 3 Networks. VXLAN is often used
 	  to tunnel virtual network infrastructure in virtualized environments.
@@ -199,12 +199,12 @@ config VXLAN
 	  will be called vxlan.
 
 config GENEVE
-       tristate "Generic Network Virtualization Encapsulation"
-       depends on INET
-       depends on IPV6 || !IPV6
-       select NET_UDP_TUNNEL
-       select GRO_CELLS
-       ---help---
+	tristate "Generic Network Virtualization Encapsulation"
+	depends on INET
+	depends on IPV6 || !IPV6
+	select NET_UDP_TUNNEL
+	select GRO_CELLS
+	---help---
 	  This allows one to create geneve virtual interfaces that provide
 	  Layer 2 Networks over Layer 3 Networks. GENEVE is often used
 	  to tunnel virtual network infrastructure in virtualized environments.
@@ -238,7 +238,7 @@ config MACSEC
 	select CRYPTO_GCM
 	select GRO_CELLS
 	---help---
-	   MACsec is an encryption standard for Ethernet.
+	  MACsec is an encryption standard for Ethernet.
 
 config NETCONSOLE
 	tristate "Network console logging support"
@@ -361,12 +361,12 @@ config NET_VRF
 	  support enables VRF devices.
 
 config VSOCKMON
-    tristate "Virtual vsock monitoring device"
-    depends on VHOST_VSOCK
-    ---help---
-     This option enables a monitoring net device for vsock sockets. It is
-     mostly intended for developers or support to debug vsock issues. If
-     unsure, say N.
+	tristate "Virtual vsock monitoring device"
+	depends on VHOST_VSOCK
+	---help---
+	  This option enables a monitoring net device for vsock sockets. It is
+	  mostly intended for developers or support to debug vsock issues. If
+	  unsure, say N.
 
 endif # NET_CORE
 
@@ -486,7 +486,7 @@ config FUJITSU_ES
 	depends on ACPI
 	help
 	  This driver provides support for Extended Socket network device
-          on Extended Partitioning of FUJITSU PRIMEQUEST 2000 E2 series.
+	  on Extended Partitioning of FUJITSU PRIMEQUEST 2000 E2 series.
 
 config THUNDERBOLT_NET
 	tristate "Networking over Thunderbolt cable"
diff --git a/drivers/net/appletalk/Kconfig b/drivers/net/appletalk/Kconfig
index dc6b78e..d3c444e5aa 100644
--- a/drivers/net/appletalk/Kconfig
+++ b/drivers/net/appletalk/Kconfig
@@ -36,7 +36,6 @@ config DEV_APPLETALK
 	  on a network.  If your Linux box is connected to such a network, and wish
 	  to do IP over it, or you have a LocalTalk card and wish to use it to
 	  connect to the AppleTalk network, say Y.
-	  
 
 config LTPC
 	tristate "Apple/Farallon LocalTalk PC support"
diff --git a/drivers/net/arcnet/Kconfig b/drivers/net/arcnet/Kconfig
index 39bd16f..4dbc1dc 100644
--- a/drivers/net/arcnet/Kconfig
+++ b/drivers/net/arcnet/Kconfig
@@ -55,19 +55,19 @@ config ARCNET_CAP
 	tristate "Enable CAP mode packet interface"
 	help
 	  ARCnet "cap mode" packet encapsulation. Used to get the hardware
-          acknowledge back to userspace. After the initial protocol byte every
-          packet is stuffed with an extra 4 byte "cookie" which doesn't
-          actually appear on the network. After transmit the driver will send
-          back a packet with protocol byte 0 containing the status of the
-          transmission:
-             0=no hardware acknowledge
-             1=excessive nak
-             2=transmission accepted by the receiver hardware
-
-          Received packets are also stuffed with the extra 4 bytes but it will
-          be random data.
-
-          Cap only listens to protocol 1-8.
+	  acknowledge back to userspace. After the initial protocol byte every
+	  packet is stuffed with an extra 4 byte "cookie" which doesn't
+	  actually appear on the network. After transmit the driver will send
+	  back a packet with protocol byte 0 containing the status of the
+	  transmission:
+	     0=no hardware acknowledge
+	     1=excessive nak
+	     2=transmission accepted by the receiver hardware
+
+	  Received packets are also stuffed with the extra 4 bytes but it will
+	  be random data.
+
+	  Cap only listens to protocol 1-8.
 
 config ARCNET_COM90xx
 	tristate "ARCnet COM90xx (normal) chipset driver"
diff --git a/drivers/net/caif/Kconfig b/drivers/net/caif/Kconfig
index f81df91..52cf6b5 100644
--- a/drivers/net/caif/Kconfig
+++ b/drivers/net/caif/Kconfig
@@ -9,37 +9,37 @@ config CAIF_TTY
 	depends on CAIF && TTY
 	default n
 	---help---
-	The CAIF TTY transport driver is a Line Discipline (ldisc)
-	identified as N_CAIF. When this ldisc is opened from user space
-	it will redirect the TTY's traffic into the CAIF stack.
+	  The CAIF TTY transport driver is a Line Discipline (ldisc)
+	  identified as N_CAIF. When this ldisc is opened from user space
+	  it will redirect the TTY's traffic into the CAIF stack.
 
 config CAIF_SPI_SLAVE
 	tristate "CAIF SPI transport driver for slave interface"
 	depends on CAIF && HAS_DMA
 	default n
 	---help---
-	The CAIF Link layer SPI Protocol driver for Slave SPI interface.
-	This driver implements a platform driver to accommodate for a
-	platform specific SPI device. A sample CAIF SPI Platform device is
-	provided in Documentation/networking/caif/spi_porting.txt
+	  The CAIF Link layer SPI Protocol driver for Slave SPI interface.
+	  This driver implements a platform driver to accommodate for a
+	  platform specific SPI device. A sample CAIF SPI Platform device is
+	 provided in Documentation/networking/caif/spi_porting.txt
 
 config CAIF_SPI_SYNC
 	bool "Next command and length in start of frame"
 	depends on CAIF_SPI_SLAVE
 	default n
 	---help---
-	Putting the next command and length in the start of the frame can
-	help to synchronize to the next transfer in case of over or under-runs.
-	This option also needs to be enabled on the modem.
+	  Putting the next command and length in the start of the frame can
+	  help to synchronize to the next transfer in case of over or under-runs.
+	  This option also needs to be enabled on the modem.
 
 config CAIF_HSI
-       tristate "CAIF HSI transport driver"
-       depends on CAIF
-       default n
-       ---help---
-       The caif low level driver for CAIF over HSI.
-       Be aware that if you enable this then you also need to
-       enable a low-level HSI driver.
+	tristate "CAIF HSI transport driver"
+	depends on CAIF
+	default n
+	---help---
+	  The caif low level driver for CAIF over HSI.
+	  Be aware that if you enable this then you also need to
+	  enable a low-level HSI driver.
 
 config CAIF_VIRTIO
 	tristate "CAIF virtio transport driver"
@@ -49,7 +49,7 @@ config CAIF_VIRTIO
 	select GENERIC_ALLOCATOR
 	default n
 	---help---
-	The caif driver for CAIF over Virtio.
+	  The caif driver for CAIF over Virtio.
 
 if CAIF_VIRTIO
 source "drivers/vhost/Kconfig.vringh"
diff --git a/drivers/net/can/usb/Kconfig b/drivers/net/can/usb/Kconfig
index 750d04d..82753ff 100644
--- a/drivers/net/can/usb/Kconfig
+++ b/drivers/net/can/usb/Kconfig
@@ -14,10 +14,10 @@ config CAN_EMS_USB
 	  from EMS Dr. Thomas Wuensche (http://www.ems-wuensche.de).
 
 config CAN_ESD_USB2
-        tristate "ESD USB/2 CAN/USB interface"
-        ---help---
-          This driver supports the CAN-USB/2 interface
-          from esd electronic system design gmbh (http://www.esd.eu).
+	tristate "ESD USB/2 CAN/USB interface"
+	---help---
+	  This driver supports the CAN-USB/2 interface
+	  from esd electronic system design gmbh (http://www.esd.eu).
 
 config CAN_GS_USB
 	tristate "Geschwister Schneider UG interfaces"
diff --git a/drivers/net/ethernet/allwinner/Kconfig b/drivers/net/ethernet/allwinner/Kconfig
index 47da7e7..5639bc5 100644
--- a/drivers/net/ethernet/allwinner/Kconfig
+++ b/drivers/net/ethernet/allwinner/Kconfig
@@ -20,17 +20,17 @@ config NET_VENDOR_ALLWINNER
 if NET_VENDOR_ALLWINNER
 
 config SUN4I_EMAC
-        tristate "Allwinner A10 EMAC support"
+	tristate "Allwinner A10 EMAC support"
 	depends on ARCH_SUNXI
 	depends on OF
 	select CRC32
 	select MII
 	select PHYLIB
 	select MDIO_SUN4I
-        ---help---
-          Support for Allwinner A10 EMAC ethernet driver.
+	---help---
+	  Support for Allwinner A10 EMAC ethernet driver.
 
-          To compile this driver as a module, choose M here.  The module
-          will be called sun4i-emac.
+	  To compile this driver as a module, choose M here.  The module
+	  will be called sun4i-emac.
 
 endif # NET_VENDOR_ALLWINNER
diff --git a/drivers/net/ethernet/aurora/Kconfig b/drivers/net/ethernet/aurora/Kconfig
index 392f564..21d3037 100644
--- a/drivers/net/ethernet/aurora/Kconfig
+++ b/drivers/net/ethernet/aurora/Kconfig
@@ -17,6 +17,6 @@ config AURORA_NB8800
 	depends on HAS_DMA
 	select PHYLIB
 	help
-	 Support for the AU-NB8800 gigabit Ethernet controller.
+	  Support for the AU-NB8800 gigabit Ethernet controller.
 
 endif
diff --git a/drivers/net/ethernet/dec/tulip/Kconfig b/drivers/net/ethernet/dec/tulip/Kconfig
index 264e9b4..de57264 100644
--- a/drivers/net/ethernet/dec/tulip/Kconfig
+++ b/drivers/net/ethernet/dec/tulip/Kconfig
@@ -44,7 +44,7 @@ config TULIP
 	select CRC32
 	---help---
 	  This driver is developed for the SMC EtherPower series Ethernet
-	  cards and also works with cards based on the DECchip 
+	  cards and also works with cards based on the DECchip
 	  21140 (Tulip series) chips.  Some LinkSys PCI cards are
 	  of this type.  (If your card is NOT SMC EtherPower 10/100 PCI
 	  (smc9332dst), you can also try the driver for "Generic DECchip"
@@ -124,7 +124,7 @@ config WINBOND_840
 	select CRC32
 	select MII
 	---help---
-	  This driver is for the Winbond W89c840 chip.  It also works with 
+	  This driver is for the Winbond W89c840 chip.  It also works with
 	  the TX9882 chip on the Compex RL100-ATX board.
 	  More specific information and updates are available from
 	  <http://www.scyld.com/network/drivers.html>.
@@ -152,7 +152,7 @@ config ULI526X
 
 	  To compile this driver as a module, choose M here. The module will
 	  be called uli526x.
-	  
+
 config PCMCIA_XIRCOM
 	tristate "Xircom CardBus support"
 	depends on CARDBUS
diff --git a/drivers/net/ethernet/emulex/benet/Kconfig b/drivers/net/ethernet/emulex/benet/Kconfig
index 8cf794e..97051ad 100644
--- a/drivers/net/ethernet/emulex/benet/Kconfig
+++ b/drivers/net/ethernet/emulex/benet/Kconfig
@@ -47,5 +47,5 @@ config BE2NET_SKYHAWK
 	  chipsets. (e.g. OneConnect OCe14xxx)
 
 comment "WARNING: be2net is useless without any enabled chip"
-        depends on BE2NET_BE2=n && BE2NET_BE3=n && BE2NET_LANCER=n && \
+	depends on BE2NET_BE2=n && BE2NET_BE3=n && BE2NET_LANCER=n && \
 	BE2NET_SKYHAWK=n && BE2NET
diff --git a/drivers/net/ethernet/freescale/fs_enet/Kconfig b/drivers/net/ethernet/freescale/fs_enet/Kconfig
index be92229..d0cef27 100644
--- a/drivers/net/ethernet/freescale/fs_enet/Kconfig
+++ b/drivers/net/ethernet/freescale/fs_enet/Kconfig
@@ -1,8 +1,8 @@
 config FS_ENET
-       tristate "Freescale Ethernet Driver"
-       depends on NET_VENDOR_FREESCALE && (CPM1 || CPM2 || PPC_MPC512x)
-       select MII
-       select PHYLIB
+	tristate "Freescale Ethernet Driver"
+	depends on NET_VENDOR_FREESCALE && (CPM1 || CPM2 || PPC_MPC512x)
+	select MII
+	select PHYLIB
 
 config FS_ENET_MPC5121_FEC
 	def_bool y if (FS_ENET && PPC_MPC512x)
diff --git a/drivers/net/ethernet/intel/Kconfig b/drivers/net/ethernet/intel/Kconfig
index a1246e8..0af26b3 100644
--- a/drivers/net/ethernet/intel/Kconfig
+++ b/drivers/net/ethernet/intel/Kconfig
@@ -79,9 +79,9 @@ config E1000E_HWTS
 	default y
 	depends on E1000E && X86
 	---help---
-	 Say Y to enable hardware supported cross-timestamping on PCH
-	 devices. The cross-timestamp is available through the PTP clock
-	 driver precise cross-timestamp ioctl (PTP_SYS_OFFSET_PRECISE).
+	  Say Y to enable hardware supported cross-timestamping on PCH
+	  devices. The cross-timestamp is available through the PTP clock
+	  driver precise cross-timestamp ioctl (PTP_SYS_OFFSET_PRECISE).
 
 config IGB
 	tristate "Intel(R) 82575/82576 PCI-Express Gigabit Ethernet support"
diff --git a/drivers/net/ethernet/marvell/Kconfig b/drivers/net/ethernet/marvell/Kconfig
index 3238aa7..6ee36cf 100644
--- a/drivers/net/ethernet/marvell/Kconfig
+++ b/drivers/net/ethernet/marvell/Kconfig
@@ -136,10 +136,10 @@ config SKGE_GENESIS
 	bool "Support for older SysKonnect Genesis boards"
 	depends on SKGE
 	---help---
-	 This enables support for the older and uncommon SysKonnect Genesis
-	 chips, which support MII via an external transceiver, instead of
-	 an internal one. Disabling this option will save some memory
-	 by making code smaller. If unsure say Y.
+	  This enables support for the older and uncommon SysKonnect Genesis
+	  chips, which support MII via an external transceiver, instead of
+	  an internal one. Disabling this option will save some memory
+	  by making code smaller. If unsure say Y.
 
 config SKY2
 	tristate "Marvell Yukon 2 support"
@@ -167,7 +167,6 @@ config SKY2_DEBUG
 
 	  If unsure, say N.
 
-
 source "drivers/net/ethernet/marvell/octeontx2/Kconfig"
 
 endif # NET_VENDOR_MARVELL
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/Kconfig b/drivers/net/ethernet/mellanox/mlx5/core/Kconfig
index 6debffb..24073aa 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/Kconfig
+++ b/drivers/net/ethernet/mellanox/mlx5/core/Kconfig
@@ -16,15 +16,15 @@ config MLX5_ACCEL
 	bool
 
 config MLX5_FPGA
-        bool "Mellanox Technologies Innova support"
-        depends on MLX5_CORE
+	bool "Mellanox Technologies Innova support"
+	depends on MLX5_CORE
 	select MLX5_ACCEL
-        ---help---
-          Build support for the Innova family of network cards by Mellanox
-          Technologies. Innova network cards are comprised of a ConnectX chip
-          and an FPGA chip on one board. If you select this option, the
-          mlx5_core driver will include the Innova FPGA core and allow building
-          sandbox-specific client drivers.
+	---help---
+	  Build support for the Innova family of network cards by Mellanox
+	  Technologies. Innova network cards are comprised of a ConnectX chip
+	  and an FPGA chip on one board. If you select this option, the
+	  mlx5_core driver will include the Innova FPGA core and allow building
+	  sandbox-specific client drivers.
 
 config MLX5_CORE_EN
 	bool "Mellanox 5th generation network adapters (ConnectX series) Ethernet support"
@@ -54,14 +54,14 @@ config MLX5_EN_RXNFC
 	  API.
 
 config MLX5_MPFS
-        bool "Mellanox Technologies MLX5 MPFS support"
-        depends on MLX5_CORE_EN
+	bool "Mellanox Technologies MLX5 MPFS support"
+	depends on MLX5_CORE_EN
 	default y
-        ---help---
+	---help---
 	  Mellanox Technologies Ethernet Multi-Physical Function Switch (MPFS)
-          support in ConnectX NIC. MPFs is required for when multi-PF configuration
-          is enabled to allow passing user configured unicast MAC addresses to the
-          requesting PF.
+	  support in ConnectX NIC. MPFs is required for when multi-PF configuration
+	  is enabled to allow passing user configured unicast MAC addresses to the
+	  requesting PF.
 
 config MLX5_ESWITCH
 	bool "Mellanox Technologies MLX5 SRIOV E-Switch support"
@@ -69,10 +69,10 @@ config MLX5_ESWITCH
 	default y
 	---help---
 	  Mellanox Technologies Ethernet SRIOV E-Switch support in ConnectX NIC.
-          E-Switch provides internal SRIOV packet steering and switching for the
-          enabled VFs and PF in two available modes:
-                Legacy SRIOV mode (L2 mac vlan steering based).
-                Switchdev mode (eswitch offloads).
+	  E-Switch provides internal SRIOV packet steering and switching for the
+	  enabled VFs and PF in two available modes:
+	        Legacy SRIOV mode (L2 mac vlan steering based).
+	        Switchdev mode (eswitch offloads).
 
 config MLX5_CORE_EN_DCB
 	bool "Data Center Bridging (DCB) Support"
diff --git a/drivers/net/ethernet/mellanox/mlxsw/Kconfig b/drivers/net/ethernet/mellanox/mlxsw/Kconfig
index 9c195df..097d841 100644
--- a/drivers/net/ethernet/mellanox/mlxsw/Kconfig
+++ b/drivers/net/ethernet/mellanox/mlxsw/Kconfig
@@ -24,8 +24,8 @@ config MLXSW_CORE_THERMAL
 	depends on !(MLXSW_CORE=y && THERMAL=m)
 	default y
 	---help---
-	 Say Y here if you want to automatically control fans speed according
-	 ambient temperature reported by ASIC.
+	  Say Y here if you want to automatically control fans speed according
+	  ambient temperature reported by ASIC.
 
 config MLXSW_PCI
 	tristate "PCI bus implementation for Mellanox Technologies Switch ASICs"
diff --git a/drivers/net/ethernet/microchip/Kconfig b/drivers/net/ethernet/microchip/Kconfig
index cf1d491..a4c3aee 100644
--- a/drivers/net/ethernet/microchip/Kconfig
+++ b/drivers/net/ethernet/microchip/Kconfig
@@ -33,13 +33,13 @@ config ENC28J60_WRITEVERIFY
 	  If unsure, say N.
 
 config ENCX24J600
-    tristate "ENCX24J600 support"
-    depends on SPI
-    ---help---
-      Support for the Microchip ENC424J600/624J600 ethernet chip.
+	tristate "ENCX24J600 support"
+	depends on SPI
+	---help---
+	  Support for the Microchip ENC424J600/624J600 ethernet chip.
 
-      To compile this driver as a module, choose M here. The module will be
-      called encx24j600.
+	  To compile this driver as a module, choose M here. The module will be
+	  called encx24j600.
 
 config LAN743X
 	tristate "LAN743x support"
diff --git a/drivers/net/ethernet/nxp/Kconfig b/drivers/net/ethernet/nxp/Kconfig
index 0d9baf9..8ffb940 100644
--- a/drivers/net/ethernet/nxp/Kconfig
+++ b/drivers/net/ethernet/nxp/Kconfig
@@ -1,8 +1,8 @@
 config LPC_ENET
-        tristate "NXP ethernet MAC on LPC devices"
-        depends on ARCH_LPC32XX
-        select PHYLIB
-        help
+	tristate "NXP ethernet MAC on LPC devices"
+	depends on ARCH_LPC32XX
+	select PHYLIB
+	help
 	  Say Y or M here if you want to use the NXP ethernet MAC included on
 	  some NXP LPC devices. You can safely enable this option for LPC32xx
 	  SoC. Also available as a module.
diff --git a/drivers/net/hamradio/Kconfig b/drivers/net/hamradio/Kconfig
index bf5e596..ef1036a 100644
--- a/drivers/net/hamradio/Kconfig
+++ b/drivers/net/hamradio/Kconfig
@@ -190,4 +190,3 @@ config YAM
 	  To compile this driver as a module, choose M here: the module
 	  will be called yam.
 
- 
diff --git a/drivers/net/ieee802154/Kconfig b/drivers/net/ieee802154/Kconfig
index 0e372f3..fcc7c8d 100644
--- a/drivers/net/ieee802154/Kconfig
+++ b/drivers/net/ieee802154/Kconfig
@@ -73,9 +73,9 @@ config IEEE802154_ATUSB
 	  The module will be called 'atusb'.
 
 config IEEE802154_ADF7242
-       tristate "ADF7242 transceiver driver"
-       depends on IEEE802154_DRIVERS && MAC802154
-       depends on SPI
+	tristate "ADF7242 transceiver driver"
+	depends on IEEE802154_DRIVERS && MAC802154
+	depends on SPI
 	---help---
 	  Say Y here to enable the ADF7242 SPI 802.15.4 wireless
 	  controller.
@@ -106,9 +106,9 @@ config IEEE802154_CA8210_DEBUGFS
 	  management entities.
 
 config IEEE802154_MCR20A
-       tristate "MCR20A transceiver driver"
-       depends on IEEE802154_DRIVERS && MAC802154
-       depends on SPI
+	tristate "MCR20A transceiver driver"
+	depends on IEEE802154_DRIVERS && MAC802154
+	depends on SPI
 	---help---
 	  Say Y here to enable the MCR20A SPI 802.15.4 wireless
 	  controller.
diff --git a/drivers/net/phy/Kconfig b/drivers/net/phy/Kconfig
index 071869d..b000b7e 100644
--- a/drivers/net/phy/Kconfig
+++ b/drivers/net/phy/Kconfig
@@ -417,9 +417,9 @@ config RENESAS_PHY
 	  Supports the Renesas PHYs uPD60620 and uPD60620A.
 
 config ROCKCHIP_PHY
-        tristate "Driver for Rockchip Ethernet PHYs"
-        ---help---
-          Currently supports the integrated Ethernet PHY.
+	tristate "Driver for Rockchip Ethernet PHYs"
+	---help---
+	  Currently supports the integrated Ethernet PHY.
 
 config SMSC_PHY
 	tristate "SMSC PHYs"
diff --git a/drivers/net/usb/Kconfig b/drivers/net/usb/Kconfig
index 860352a..b1b325e 100644
--- a/drivers/net/usb/Kconfig
+++ b/drivers/net/usb/Kconfig
@@ -168,7 +168,7 @@ config USB_NET_AX8817X
 	  This option adds support for ASIX AX88xxx based USB 2.0
 	  10/100 Ethernet adapters.
 
- 	  This driver should work with at least the following devices:
+	  This driver should work with at least the following devices:
 	    * Aten UC210T
 	    * ASIX AX88172
 	    * Billionton Systems, USB2AR
@@ -219,13 +219,13 @@ config USB_NET_CDCETHER
 	  CDC Ethernet is an implementation option for DOCSIS cable modems
 	  that support USB connectivity, used for non-Microsoft USB hosts.
 	  The Linux-USB CDC Ethernet Gadget driver is an open implementation.
- 	  This driver should work with at least the following devices:
+	  This driver should work with at least the following devices:
 
 	    * Dell Wireless 5530 HSPA
- 	    * Ericsson PipeRider (all variants)
+	    * Ericsson PipeRider (all variants)
 	    * Ericsson Mobile Broadband Module (all variants)
- 	    * Motorola (DM100 and SB4100)
- 	    * Broadcom Cable Modem (reference design)
+	    * Motorola (DM100 and SB4100)
+	    * Broadcom Cable Modem (reference design)
 	    * Toshiba (PCX1100U and F3507g/F3607gw)
 	    * ...
 
diff --git a/drivers/net/wan/Kconfig b/drivers/net/wan/Kconfig
index 4e9fe75..61ab18d 100644
--- a/drivers/net/wan/Kconfig
+++ b/drivers/net/wan/Kconfig
@@ -48,7 +48,7 @@ config COSA
 	  network device.
 
 	  You will need user-space utilities COSA or SRP boards for downloading
- 	  the firmware to the cards and to set them up. Look at the
+	  the firmware to the cards and to set them up. Look at the
 	  <http://www.fi.muni.cz/~kas/cosa/> for more information. You can also
 	  read the comment at the top of the <file:drivers/net/wan/cosa.c> for
 	  details about the cards and the driver itself.
@@ -107,7 +107,7 @@ config HDLC
 	  Generic HDLC driver currently supports raw HDLC, Cisco HDLC, Frame
 	  Relay, synchronous Point-to-Point Protocol (PPP) and X.25.
 
- 	  To compile this driver as a module, choose M here: the
+	  To compile this driver as a module, choose M here: the
 	  module will be called hdlc.
 
 	  If unsure, say N.
diff --git a/drivers/net/wireless/ath/Kconfig b/drivers/net/wireless/ath/Kconfig
index 82ab7c3..385689b 100644
--- a/drivers/net/wireless/ath/Kconfig
+++ b/drivers/net/wireless/ath/Kconfig
@@ -29,12 +29,12 @@ config ATH_DEBUG
 	  Right now only ath9k makes use of this.
 
 config ATH_TRACEPOINTS
-       bool "Atheros wireless tracing"
-       depends on ATH_DEBUG
-       depends on EVENT_TRACING
-       ---help---
-         This option enables tracepoints for atheros wireless drivers.
-	 Currently, ath9k makes use of this facility.
+	bool "Atheros wireless tracing"
+	depends on ATH_DEBUG
+	depends on EVENT_TRACING
+	---help---
+	  This option enables tracepoints for atheros wireless drivers.
+	  Currently, ath9k makes use of this facility.
 
 config ATH_REG_DYNAMIC_USER_REG_HINTS
 	bool "Atheros dynamic user regulatory hints"
diff --git a/drivers/net/wireless/ath/ar5523/Kconfig b/drivers/net/wireless/ath/ar5523/Kconfig
index 0d320cc..28eb4e9 100644
--- a/drivers/net/wireless/ath/ar5523/Kconfig
+++ b/drivers/net/wireless/ath/ar5523/Kconfig
@@ -1,8 +1,8 @@
 config AR5523
-       tristate "Atheros AR5523 wireless driver support"
-       depends on MAC80211 && USB
-       select ATH_COMMON
-       select FW_LOADER
-       ---help---
-         This module add support for AR5523 based USB dongles such as D-Link
-         DWL-G132, Netgear WPN111 and many more.
+	tristate "Atheros AR5523 wireless driver support"
+	depends on MAC80211 && USB
+	select ATH_COMMON
+	select FW_LOADER
+	---help---
+	  This module add support for AR5523 based USB dongles such as D-Link
+	  DWL-G132, Netgear WPN111 and many more.
diff --git a/drivers/net/wireless/ath/ath9k/Kconfig b/drivers/net/wireless/ath/ath9k/Kconfig
index ceca23a..d96e212 100644
--- a/drivers/net/wireless/ath/ath9k/Kconfig
+++ b/drivers/net/wireless/ath/ath9k/Kconfig
@@ -1,10 +1,13 @@
 config ATH9K_HW
 	tristate
+
 config ATH9K_COMMON
 	tristate
 	select ATH_COMMON
+
 config ATH9K_COMMON_DEBUG
 	bool
+
 config ATH9K_DFS_DEBUGFS
 	def_bool y
 	depends on ATH9K_DEBUGFS && ATH9K_DFS_CERTIFIED
@@ -143,13 +146,13 @@ config ATH9K_RFKILL
 	  a platform that can toggle the RF-Kill GPIO.
 
 config ATH9K_CHANNEL_CONTEXT
-       bool "Channel Context support"
-       depends on ATH9K
-       default n
-       ---help---
-         This option enables channel context support in ath9k, which is needed
-	 for multi-channel concurrency. Enable this if P2P PowerSave support
-	 is required.
+	bool "Channel Context support"
+	depends on ATH9K
+	default n
+	---help---
+	  This option enables channel context support in ath9k, which is needed
+	  for multi-channel concurrency. Enable this if P2P PowerSave support
+	  is required.
 
 config ATH9K_PCOEM
 	bool "Atheros ath9k support for PC OEM cards" if EXPERT
@@ -157,20 +160,20 @@ config ATH9K_PCOEM
 	default y
 
 config ATH9K_HTC
-       tristate "Atheros HTC based wireless cards support"
-       depends on USB && MAC80211
-       select ATH9K_HW
-       select MAC80211_LEDS
-       select LEDS_CLASS
-       select NEW_LEDS
-       select ATH9K_COMMON
-       ---help---
-	 Support for Atheros HTC based cards.
-	 Chipsets supported: AR9271
-
-	 For more information: http://wireless.kernel.org/en/users/Drivers/ath9k_htc
-
-	 The built module will be ath9k_htc.
+	tristate "Atheros HTC based wireless cards support"
+	depends on USB && MAC80211
+	select ATH9K_HW
+	select MAC80211_LEDS
+	select LEDS_CLASS
+	select NEW_LEDS
+	select ATH9K_COMMON
+	---help---
+	  Support for Atheros HTC based cards.
+	  Chipsets supported: AR9271
+
+	  For more information: http://wireless.kernel.org/en/users/Drivers/ath9k_htc
+
+	  The built module will be ath9k_htc.
 
 config ATH9K_HTC_DEBUGFS
 	bool "Atheros ath9k_htc debugging"
diff --git a/drivers/net/wireless/ath/carl9170/Kconfig b/drivers/net/wireless/ath/carl9170/Kconfig
index 2e34bae..ecd4472 100644
--- a/drivers/net/wireless/ath/carl9170/Kconfig
+++ b/drivers/net/wireless/ath/carl9170/Kconfig
@@ -40,9 +40,9 @@ config CARL9170_WPC
 	default y
 
 config CARL9170_HWRNG
-        bool "Random number generator"
-        depends on CARL9170 && (HW_RANDOM = y || HW_RANDOM = CARL9170)
-        default n
+	bool "Random number generator"
+	depends on CARL9170 && (HW_RANDOM = y || HW_RANDOM = CARL9170)
+	default n
 	help
 	  Provides a hardware random number generator to the kernel.
 
diff --git a/drivers/net/wireless/atmel/Kconfig b/drivers/net/wireless/atmel/Kconfig
index 3e684f8..e385c50 100644
--- a/drivers/net/wireless/atmel/Kconfig
+++ b/drivers/net/wireless/atmel/Kconfig
@@ -12,29 +12,29 @@ config WLAN_VENDOR_ATMEL
 if WLAN_VENDOR_ATMEL
 
 config ATMEL
-      tristate "Atmel at76c50x chipset  802.11b support"
-      depends on CFG80211 && (PCI || PCMCIA)
-      select WIRELESS_EXT
-      select WEXT_PRIV
-      select FW_LOADER
-      select CRC32
-       ---help---
-        A driver 802.11b wireless cards based on the Atmel fast-vnet
-        chips. This driver supports standard Linux wireless extensions.
-
-        Many  cards based on this chipset do not have flash memory
-        and need their firmware loaded at start-up. If yours is
-        one of these, you will need to provide a firmware image
-        to be loaded into the card by the driver. The Atmel
-        firmware package can be downloaded from
-        <http://www.thekelleys.org.uk/atmel>
+	tristate "Atmel at76c50x chipset  802.11b support"
+	depends on CFG80211 && (PCI || PCMCIA)
+	select WIRELESS_EXT
+	select WEXT_PRIV
+	select FW_LOADER
+	select CRC32
+	---help---
+	  A driver 802.11b wireless cards based on the Atmel fast-vnet
+	  chips. This driver supports standard Linux wireless extensions.
+
+	  Many  cards based on this chipset do not have flash memory
+	  and need their firmware loaded at start-up. If yours is
+	  one of these, you will need to provide a firmware image
+	  to be loaded into the card by the driver. The Atmel
+	  firmware package can be downloaded from
+	  <http://www.thekelleys.org.uk/atmel>
 
 config PCI_ATMEL
-      tristate "Atmel at76c506 PCI cards"
-      depends on ATMEL && PCI
-       ---help---
-        Enable support for PCI and mini-PCI cards containing the
-        Atmel at76c506 chip.
+	tristate "Atmel at76c506 PCI cards"
+	depends on ATMEL && PCI
+	---help---
+	  Enable support for PCI and mini-PCI cards containing the
+	  Atmel at76c506 chip.
 
 config PCMCIA_ATMEL
 	tristate "Atmel at76c502/at76c504 PCMCIA cards"
@@ -47,11 +47,11 @@ config PCMCIA_ATMEL
 	  Atmel at76c502 and at76c504 chips.
 
 config AT76C50X_USB
-        tristate "Atmel at76c503/at76c505/at76c505a USB cards"
-        depends on MAC80211 && USB
-        select FW_LOADER
-        ---help---
-          Enable support for USB Wireless devices using Atmel at76c503,
-          at76c505 or at76c505a chips.
+	tristate "Atmel at76c503/at76c505/at76c505a USB cards"
+	depends on MAC80211 && USB
+	select FW_LOADER
+	---help---
+	  Enable support for USB Wireless devices using Atmel at76c503,
+	  at76c505 or at76c505a chips.
 
 endif # WLAN_VENDOR_ATMEL
diff --git a/drivers/net/wireless/intel/ipw2x00/Kconfig b/drivers/net/wireless/intel/ipw2x00/Kconfig
index 5623955..44b3c0a 100644
--- a/drivers/net/wireless/intel/ipw2x00/Kconfig
+++ b/drivers/net/wireless/intel/ipw2x00/Kconfig
@@ -12,37 +12,37 @@ config IPW2100
 	select LIB80211
 	select LIBIPW
 	---help---
-          A driver for the Intel PRO/Wireless 2100 Network 
+	  A driver for the Intel PRO/Wireless 2100 Network
 	  Connection 802.11b wireless network adapter.
 
-          See <file:Documentation/networking/device_drivers/intel/ipw2100.txt>
+	  See <file:Documentation/networking/device_drivers/intel/ipw2100.txt>
 	  for information on the capabilities currently enabled in this driver
 	  and for tips for debugging issues and problems.
 
 	  In order to use this driver, you will need a firmware image for it.
-          You can obtain the firmware from
-	  <http://ipw2100.sf.net/>.  Once you have the firmware image, you 
+	  You can obtain the firmware from
+	  <http://ipw2100.sf.net/>.  Once you have the firmware image, you
 	  will need to place it in /lib/firmware.
 
-          You will also very likely need the Wireless Tools in order to
-          configure your card:
+	  You will also very likely need the Wireless Tools in order to
+	  configure your card:
 
-          <http://www.hpl.hp.com/personal/Jean_Tourrilhes/Linux/Tools.html>.
+	  <http://www.hpl.hp.com/personal/Jean_Tourrilhes/Linux/Tools.html>.
+
+	  It is recommended that you compile this driver as a module (M)
+	  rather than built-in (Y). This driver requires firmware at device
+	  initialization time, and when built-in this typically happens
+	  before the filesystem is accessible (hence firmware will be
+	  unavailable and initialization will fail). If you do choose to build
+	  this driver into your kernel image, you can avoid this problem by
+	  including the firmware and a firmware loader in an initramfs.
 
-          It is recommended that you compile this driver as a module (M)
-          rather than built-in (Y). This driver requires firmware at device
-          initialization time, and when built-in this typically happens
-          before the filesystem is accessible (hence firmware will be
-          unavailable and initialization will fail). If you do choose to build
-          this driver into your kernel image, you can avoid this problem by
-          including the firmware and a firmware loader in an initramfs.
- 
 config IPW2100_MONITOR
-        bool "Enable promiscuous mode"
-        depends on IPW2100
-        ---help---
+	bool "Enable promiscuous mode"
+	depends on IPW2100
+	---help---
 	  Enables promiscuous/monitor mode support for the ipw2100 driver.
-	  With this feature compiled into the driver, you can switch to 
+	  With this feature compiled into the driver, you can switch to
 	  promiscuous mode via the Wireless Tool's Monitor mode.  While in this
 	  mode, no packets can be sent.
 
@@ -50,17 +50,17 @@ config IPW2100_DEBUG
 	bool "Enable full debugging output in IPW2100 module."
 	depends on IPW2100
 	---help---
-	  This option will enable debug tracing output for the IPW2100.  
+	  This option will enable debug tracing output for the IPW2100.
 
-	  This will result in the kernel module being ~60k larger.  You can 
-	  control which debug output is sent to the kernel log by setting the 
-	  value in 
+	  This will result in the kernel module being ~60k larger.  You can
+	  control which debug output is sent to the kernel log by setting the
+	  value in
 
 	  /sys/bus/pci/drivers/ipw2100/debug_level
 
 	  This entry will only exist if this option is enabled.
 
-	  If you are not trying to debug or develop the IPW2100 driver, you 
+	  If you are not trying to debug or develop the IPW2100 driver, you
 	  most likely want to say N here.
 
 config IPW2200
@@ -74,37 +74,37 @@ config IPW2200
 	select LIB80211
 	select LIBIPW
 	---help---
-          A driver for the Intel PRO/Wireless 2200BG and 2915ABG Network
-	  Connection adapters. 
+	  A driver for the Intel PRO/Wireless 2200BG and 2915ABG Network
+	  Connection adapters.
 
-          See <file:Documentation/networking/device_drivers/intel/ipw2200.txt>
+	  See <file:Documentation/networking/device_drivers/intel/ipw2200.txt>
 	  for information on the capabilities currently enabled in this
 	  driver and for tips for debugging issues and problems.
 
 	  In order to use this driver, you will need a firmware image for it.
-          You can obtain the firmware from
-	  <http://ipw2200.sf.net/>.  See the above referenced README.ipw2200 
+	  You can obtain the firmware from
+	  <http://ipw2200.sf.net/>.  See the above referenced README.ipw2200
 	  for information on where to install the firmware images.
 
-          You will also very likely need the Wireless Tools in order to
-          configure your card:
+	  You will also very likely need the Wireless Tools in order to
+	  configure your card:
 
-          <http://www.hpl.hp.com/personal/Jean_Tourrilhes/Linux/Tools.html>.
+	  <http://www.hpl.hp.com/personal/Jean_Tourrilhes/Linux/Tools.html>.
 
-          It is recommended that you compile this driver as a module (M)
-          rather than built-in (Y). This driver requires firmware at device
-          initialization time, and when built-in this typically happens
-          before the filesystem is accessible (hence firmware will be
-          unavailable and initialization will fail). If you do choose to build
-          this driver into your kernel image, you can avoid this problem by
-          including the firmware and a firmware loader in an initramfs.
+	  It is recommended that you compile this driver as a module (M)
+	  rather than built-in (Y). This driver requires firmware at device
+	  initialization time, and when built-in this typically happens
+	  before the filesystem is accessible (hence firmware will be
+	  unavailable and initialization will fail). If you do choose to build
+	  this driver into your kernel image, you can avoid this problem by
+	  including the firmware and a firmware loader in an initramfs.
 
 config IPW2200_MONITOR
-        bool "Enable promiscuous mode"
-        depends on IPW2200
-        ---help---
+	bool "Enable promiscuous mode"
+	depends on IPW2200
+	---help---
 	  Enables promiscuous/monitor mode support for the ipw2200 driver.
-	  With this feature compiled into the driver, you can switch to 
+	  With this feature compiled into the driver, you can switch to
 	  promiscuous mode via the Wireless Tool's Monitor mode.  While in this
 	  mode, no packets can be sent.
 
@@ -117,28 +117,28 @@ config IPW2200_PROMISCUOUS
 	depends on IPW2200_MONITOR
 	select IPW2200_RADIOTAP
 	---help---
-          Enables the creation of a second interface prefixed 'rtap'. 
-          This second interface will provide every received in radiotap
+	  Enables the creation of a second interface prefixed 'rtap'.
+	  This second interface will provide every received in radiotap
 	  format.
 
-          This is useful for performing wireless network analysis while
-          maintaining an active association.
+	  This is useful for performing wireless network analysis while
+	  maintaining an active association.
 
-          Example usage:
+	  Example usage:
 
-            % modprobe ipw2200 rtap_iface=1
-            % ifconfig rtap0 up
-            % tethereal -i rtap0
+	    % modprobe ipw2200 rtap_iface=1
+	    % ifconfig rtap0 up
+	    % tethereal -i rtap0
 
-          If you do not specify 'rtap_iface=1' as a module parameter then 
-          the rtap interface will not be created and you will need to turn 
-          it on via sysfs:
+	  If you do not specify 'rtap_iface=1' as a module parameter then
+	  the rtap interface will not be created and you will need to turn
+	  it on via sysfs:
 	
-            % echo 1 > /sys/bus/pci/drivers/ipw2200/*/rtap_iface
+	    % echo 1 > /sys/bus/pci/drivers/ipw2200/*/rtap_iface
 
 config IPW2200_QOS
-        bool "Enable QoS support"
-        depends on IPW2200
+	bool "Enable QoS support"
+	depends on IPW2200
 
 config IPW2200_DEBUG
 	bool "Enable full debugging output in IPW2200 module."
@@ -170,9 +170,9 @@ config LIBIPW
 	select LIB80211_CRYPT_TKIP
 	select LIB80211_CRYPT_CCMP
 	---help---
-	This option enables the hardware independent IEEE 802.11
-	networking stack.  This component is deprecated in favor of the
-	mac80211 component.
+	  This option enables the hardware independent IEEE 802.11
+	  networking stack.  This component is deprecated in favor of the
+	  mac80211 component.
 
 config LIBIPW_DEBUG
 	bool "Full debugging output for the LIBIPW component"
diff --git a/drivers/net/wireless/intel/iwlegacy/Kconfig b/drivers/net/wireless/intel/iwlegacy/Kconfig
index fb91972..45670a1 100644
--- a/drivers/net/wireless/intel/iwlegacy/Kconfig
+++ b/drivers/net/wireless/intel/iwlegacy/Kconfig
@@ -90,9 +90,9 @@ config IWLEGACY_DEBUG
 	  any problems you may encounter.
 
 config IWLEGACY_DEBUGFS
-        bool "iwlegacy (iwl 3945/4965) debugfs support"
-        depends on IWLEGACY && MAC80211_DEBUGFS
-        ---help---
+	bool "iwlegacy (iwl 3945/4965) debugfs support"
+	depends on IWLEGACY && MAC80211_DEBUGFS
+	---help---
 	  Enable creation of debugfs files for the iwlegacy drivers. This
 	  is a low-impact option that allows getting insight into the
 	  driver's state at runtime.
diff --git a/drivers/net/wireless/intel/iwlwifi/Kconfig b/drivers/net/wireless/intel/iwlwifi/Kconfig
index 83d5bce..9445e20 100644
--- a/drivers/net/wireless/intel/iwlwifi/Kconfig
+++ b/drivers/net/wireless/intel/iwlwifi/Kconfig
@@ -24,7 +24,6 @@ config IWLWIFI
 		Intel 8260 Wi-Fi Adapter
 		Intel 3165 Wi-Fi Adapter
 
-
 	  This driver uses the kernel's mac80211 subsystem.
 
 	  In order to use this driver, you will need a firmware
@@ -92,18 +91,18 @@ config IWLWIFI_BCAST_FILTERING
 	  expect incoming broadcasts for their normal operations.
 
 config IWLWIFI_PCIE_RTPM
-       bool "Enable runtime power management mode for PCIe devices"
-       depends on IWLMVM && PM && EXPERT
-       help
-         Say Y here to enable runtime power management for PCIe
-         devices.  If enabled, the device will go into low power mode
-         when idle for a short period of time, allowing for improved
-         power saving during runtime. Note that this feature requires
-         a tight integration with the platform. It is not recommended
-         to enable this feature without proper validation with the
-         specific target platform.
-
-	 If unsure, say N.
+	bool "Enable runtime power management mode for PCIe devices"
+	depends on IWLMVM && PM && EXPERT
+	help
+	  Say Y here to enable runtime power management for PCIe
+	  devices.  If enabled, the device will go into low power mode
+	  when idle for a short period of time, allowing for improved
+	  power saving during runtime. Note that this feature requires
+	  a tight integration with the platform. It is not recommended
+	  to enable this feature without proper validation with the
+	  specific target platform.
+
+	  If unsure, say N.
 
 menu "Debugging Options"
 
@@ -132,9 +131,9 @@ config IWLWIFI_DEBUG
 	  any problems you may encounter.
 
 config IWLWIFI_DEBUGFS
-        bool "iwlwifi debugfs support"
-        depends on MAC80211_DEBUGFS
-        ---help---
+	bool "iwlwifi debugfs support"
+	depends on MAC80211_DEBUGFS
+	---help---
 	  Enable creation of debugfs files for the iwlwifi drivers. This
 	  is a low-impact option that allows getting insight into the
 	  driver's state at runtime.
diff --git a/drivers/net/wireless/intersil/p54/Kconfig b/drivers/net/wireless/intersil/p54/Kconfig
index cdafb8c..a0c99d3 100644
--- a/drivers/net/wireless/intersil/p54/Kconfig
+++ b/drivers/net/wireless/intersil/p54/Kconfig
@@ -53,17 +53,17 @@ config P54_SPI_DEFAULT_EEPROM
 	depends on P54_SPI
 	default n
 	---help---
-	 Unlike the PCI or USB devices, the SPI variants don't have
-	 a dedicated EEPROM chip to store all device specific values
-	 for calibration, country and interface settings.
+	  Unlike the PCI or USB devices, the SPI variants don't have
+	  a dedicated EEPROM chip to store all device specific values
+	  for calibration, country and interface settings.
 
-	 The driver will try to load the image "3826.eeprom", if the
-	 file is put at the right place. (usually /lib/firmware.)
+	  The driver will try to load the image "3826.eeprom", if the
+	  file is put at the right place. (usually /lib/firmware.)
 
-	 Only if this request fails, this option will provide a
-	 backup set of generic values to get the device working.
+	  Only if this request fails, this option will provide a
+	  backup set of generic values to get the device working.
 
-	 Enabling this option adds about 4k to p54spi.
+	  Enabling this option adds about 4k to p54spi.
 
 config P54_LEDS
 	bool
diff --git a/drivers/net/wireless/ralink/rt2x00/Kconfig b/drivers/net/wireless/ralink/rt2x00/Kconfig
index a1d1cfe..243e08e 100644
--- a/drivers/net/wireless/ralink/rt2x00/Kconfig
+++ b/drivers/net/wireless/ralink/rt2x00/Kconfig
@@ -70,7 +70,7 @@ config RT2800PCI
 	---help---
 	  This adds support for rt27xx/rt28xx/rt30xx wireless chipset family.
 	  Supported chips: RT2760, RT2790, RT2860, RT2880, RT2890, RT3052,
-			   RT3090, RT3091 & RT3092
+	                   RT3090, RT3091 & RT3092
 
 	  When compiled as a module, this driver will be called "rt2800pci.ko".
 
@@ -94,20 +94,20 @@ config RT2800PCI_RT35XX
 
 
 config RT2800PCI_RT53XX
-       bool "rt2800pci - Include support for rt53xx devices (EXPERIMENTAL)"
-       default y
-       ---help---
-         This adds support for rt53xx wireless chipset family to the
-         rt2800pci driver.
-         Supported chips: RT5390
+	bool "rt2800pci - Include support for rt53xx devices (EXPERIMENTAL)"
+	default y
+	---help---
+	  This adds support for rt53xx wireless chipset family to the
+	  rt2800pci driver.
+	  Supported chips: RT5390
 
 config RT2800PCI_RT3290
-       bool "rt2800pci - Include support for rt3290 devices (EXPERIMENTAL)"
-       default y
-       ---help---
-         This adds support for rt3290 wireless chipset family to the
-         rt2800pci driver.
-         Supported chips: RT3290
+	bool "rt2800pci - Include support for rt3290 devices (EXPERIMENTAL)"
+	default y
+	---help---
+	  This adds support for rt3290 wireless chipset family to the
+	  rt2800pci driver.
+	  Supported chips: RT3290
 endif
 
 config RT2500USB
@@ -173,18 +173,18 @@ config RT2800USB_RT3573
 	  in the rt2800usb driver.
 
 config RT2800USB_RT53XX
-       bool "rt2800usb - Include support for rt53xx devices (EXPERIMENTAL)"
-       ---help---
-         This adds support for rt53xx wireless chipset family to the
-         rt2800usb driver.
-         Supported chips: RT5370
+	bool "rt2800usb - Include support for rt53xx devices (EXPERIMENTAL)"
+	---help---
+	  This adds support for rt53xx wireless chipset family to the
+	  rt2800usb driver.
+	  Supported chips: RT5370
 
 config RT2800USB_RT55XX
-       bool "rt2800usb - Include support for rt55xx devices (EXPERIMENTAL)"
-       ---help---
-         This adds support for rt55xx wireless chipset family to the
-         rt2800usb driver.
-         Supported chips: RT5572
+	bool "rt2800usb - Include support for rt55xx devices (EXPERIMENTAL)"
+	---help---
+	  This adds support for rt55xx wireless chipset family to the
+	  rt2800usb driver.
+	  Supported chips: RT5572
 
 config RT2800USB_UNKNOWN
 	bool "rt2800usb - Include support for unknown (USB) devices"
@@ -214,7 +214,6 @@ config RT2800SOC
 
 	  When compiled as a module, this driver will be called rt2800soc.
 
-
 config RT2800_LIB
 	tristate
 
diff --git a/drivers/net/wireless/rsi/Kconfig b/drivers/net/wireless/rsi/Kconfig
index 976c218..e801121 100644
--- a/drivers/net/wireless/rsi/Kconfig
+++ b/drivers/net/wireless/rsi/Kconfig
@@ -24,8 +24,8 @@ config RSI_DEBUGFS
 	depends on RSI_91X
 	default y
 	---help---
-	 Say Y, if you would like to enable debug support. This option
-	 creates debugfs entries
+	  Say Y, if you would like to enable debug support. This option
+	  creates debugfs entries
 
 config RSI_SDIO
 	tristate "Redpine Signals SDIO bus support"
diff --git a/drivers/net/wireless/ti/wl12xx/Kconfig b/drivers/net/wireless/ti/wl12xx/Kconfig
index c218359..b7b79a7 100644
--- a/drivers/net/wireless/ti/wl12xx/Kconfig
+++ b/drivers/net/wireless/ti/wl12xx/Kconfig
@@ -1,9 +1,9 @@
 config WL12XX
-       tristate "TI wl12xx support"
+	tristate "TI wl12xx support"
 	depends on MAC80211
-       select WLCORE
-       ---help---
+	select WLCORE
+	---help---
 	  This module adds support for wireless adapters based on TI wl1271,
 	  wl1273, wl1281 and wl1283 chipsets. This module does *not* include
 	  support for wl1251.  For wl1251 support, use the separate homonymous
-	   driver instead.
+	  driver instead.
-- 
1.9.1

