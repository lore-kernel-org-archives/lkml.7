Return-Path: <SRS0=9eWV=U5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85C0CC5B576
	for <linux-kernel@archiver.kernel.org>; Sun, 30 Jun 2019 06:24:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3E92C208C4
	for <linux-kernel@archiver.kernel.org>; Sun, 30 Jun 2019 06:24:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726525AbfF3GXm convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 30 Jun 2019 02:23:42 -0400
Received: from mga11.intel.com ([192.55.52.93]:53160 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725959AbfF3GXl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Jun 2019 02:23:41 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga102.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 29 Jun 2019 23:23:40 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.63,434,1557212400"; 
   d="scan'208";a="246574818"
Received: from fmsmsx107.amr.corp.intel.com ([10.18.124.205])
  by orsmga001.jf.intel.com with ESMTP; 29 Jun 2019 23:23:40 -0700
Received: from fmsmsx116.amr.corp.intel.com (10.18.116.20) by
 fmsmsx107.amr.corp.intel.com (10.18.124.205) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Sat, 29 Jun 2019 23:23:40 -0700
Received: from hasmsx111.ger.corp.intel.com (10.184.198.39) by
 fmsmsx116.amr.corp.intel.com (10.18.116.20) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Sat, 29 Jun 2019 23:23:38 -0700
Received: from hasmsx108.ger.corp.intel.com ([169.254.9.33]) by
 HASMSX111.ger.corp.intel.com ([169.254.5.82]) with mapi id 14.03.0439.000;
 Sun, 30 Jun 2019 09:23:36 +0300
From:   "Winkler, Tomas" <tomas.winkler@intel.com>
To:     Shreeya Patel <shreeya.patel23498@gmail.com>,
        "skhan@linuxfoundation.org" <skhan@linuxfoundation.org>,
        "corbet@lwn.net" <corbet@lwn.net>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-kernel-mentees@lists.linuxfoundation.org" 
        <linux-kernel-mentees@lists.linuxfoundation.org>
Subject: RE: [PATCH] Documentation: misc-devices: mei: Convert mei txt files
 to reST
Thread-Topic: [PATCH] Documentation: misc-devices: mei: Convert mei txt
 files to reST
Thread-Index: AQHVLsIfiYGhB6K+/kap2dTVsYiAQqazuoEQ
Date:   Sun, 30 Jun 2019 06:23:35 +0000
Message-ID: <5B8DA87D05A7694D9FA63FD143655C1B9DC547D0@hasmsx108.ger.corp.intel.com>
References: <20190629213203.5887-1-shreeya.patel23498@gmail.com>
In-Reply-To: <20190629213203.5887-1-shreeya.patel23498@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-product: dlpe-windows
dlp-version: 11.0.600.7
dlp-reaction: no-action
x-originating-ip: [10.184.70.10]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> -----Original Message-----
> From: Shreeya Patel [mailto:shreeya.patel23498@gmail.com]
> Sent: Sunday, June 30, 2019 00:32
> To: skhan@linuxfoundation.org; corbet@lwn.net; Winkler, Tomas
> <tomas.winkler@intel.com>; linux-doc@vger.kernel.org; linux-
> kernel@vger.kernel.org; linux-kernel-mentees@lists.linuxfoundation.org
> Subject: [PATCH] Documentation: misc-devices: mei: Convert mei txt files to
> reST
> 
> Convert the MEI misc device's documentation files from .txt to
> reStructuredText format. Make a minor change of correcting the wrong macro
> name MEI_CONNECT_CLIENT_IOCTL to IOCTL_MEI_CONNECT_CLIENT.
> Add an index file in mei as there are two sections for it in the documentation.
> 
> Signed-off-by: Shreeya Patel <shreeya.patel23498@gmail.com>
> ---
Sorry you are late, we've already done that, it should be merged via Greg's char-misc tree.
Thanks
Tomas



> I am not sure if I have placed the Documentation in the right place so I would
> like to get some suggestions from the MAINTAINERS on this part.
> 
>  Documentation/misc-devices/index.rst          |   1 +
>  Documentation/misc-devices/mei/index.rst      |  15 +
>  .../misc-devices/mei/mei-client-bus.rst       | 151 +++++++++
>  .../misc-devices/mei/mei-client-bus.txt       | 141 ---------
>  Documentation/misc-devices/mei/mei.rst        | 289 ++++++++++++++++++
>  Documentation/misc-devices/mei/mei.txt        | 266 ----------------
>  6 files changed, 456 insertions(+), 407 deletions(-)  create mode 100644
> Documentation/misc-devices/mei/index.rst
>  create mode 100644 Documentation/misc-devices/mei/mei-client-bus.rst
>  delete mode 100644 Documentation/misc-devices/mei/mei-client-bus.txt
>  create mode 100644 Documentation/misc-devices/mei/mei.rst
>  delete mode 100644 Documentation/misc-devices/mei/mei.txt
> 
> diff --git a/Documentation/misc-devices/index.rst b/Documentation/misc-
> devices/index.rst
> index dfd1f45a3127..e788a12b2b19 100644
> --- a/Documentation/misc-devices/index.rst
> +++ b/Documentation/misc-devices/index.rst
> @@ -15,3 +15,4 @@ fit into other categories.
>     :maxdepth: 2
> 
>     ibmvmc
> +   mei/index
> diff --git a/Documentation/misc-devices/mei/index.rst b/Documentation/misc-
> devices/mei/index.rst
> new file mode 100644
> index 000000000000..3018098ad075
> --- /dev/null
> +++ b/Documentation/misc-devices/mei/index.rst
> @@ -0,0 +1,15 @@
> +.. SPDX-License-Identifier: GPL-2.0
> +
> +===============================================================
> ==
> +Intel(R) Management Engine Interface Kernel Driver (Intel(R) MEI)
> +===============================================================
> ==
> +
> +.. class:: toc-title
> +
> +           Table of contents
> +
> +.. toctree::
> +   :maxdepth: 2
> +
> +   mei
> +   mei-client-bus
> diff --git a/Documentation/misc-devices/mei/mei-client-bus.rst
> b/Documentation/misc-devices/mei/mei-client-bus.rst
> new file mode 100644
> index 000000000000..82d455afae78
> --- /dev/null
> +++ b/Documentation/misc-devices/mei/mei-client-bus.rst
> @@ -0,0 +1,151 @@
> +.. SPDX-License-Identifier: GPL-2.0
> +
> +==============================================
> +Intel(R) Management Engine (ME) Client bus API
> +==============================================
> +
> +
> +Rationale
> +=========
> +
> +MEI misc character device is useful for dedicated applications to send
> +and receive data to the many FW appliance found in Intel's ME from the user
> space.
> +However for some of the ME functionalities it make sense to leverage
> +existing software stack and expose them through existing kernel subsystems.
> +
> +In order to plug seamlessly into the kernel device driver model we add
> +kernel virtual bus abstraction on top of the MEI driver. This allows
> +implementing linux kernel drivers for the various MEI features as a stand
> alone entities found in their respective subsystem.
> +Existing device drivers can even potentially be re-used by adding an
> +MEI CL bus layer to the existing code.
> +
> +
> +MEI CL bus API
> +==============
> +
> +A driver implementation for an MEI Client is very similar to existing
> +bus based device drivers. The driver registers itself as an MEI CL bus
> +driver through the :c:type:`mei_cl_driver` structure:
> +
> +::
> +
> +        struct mei_cl_driver {
> +	        struct device_driver driver;
> +	        const char *name;
> +
> +	        const struct mei_cl_device_id *id_table;
> +
> +	        int (*probe)(struct mei_cl_device *dev, const struct mei_cl_id
> *id);
> +	        int (*remove)(struct mei_cl_device *dev);
> +        };
> +
> +        struct mei_cl_id {
> +	        char name[MEI_NAME_SIZE];
> +	        kernel_ulong_t driver_info;
> +        };
> +
> +
> +The :c:type:`mei_cl_id` structure allows the driver to bind itself against a
> device name.
> +
> +To actually register a driver on the ME Client bus one must call the
> +:c:func:`mei_cl_add_driver()` API. This is typically called at module init time.
> +
> +Once registered on the ME Client bus, a driver will typically try to do
> +some I/O on this bus and this should be done through the
> +:c:func:`mei_cl_send()` and :c:func:`mei_cl_recv()` routines. The latter is
> synchronous (blocks and sleeps until data shows up).
> +In order for drivers to be notified of pending events waiting for them (e.g.
> +an Rx event) they can register an event handler through the
> +:c:func:`mei_cl_register_event_cb()` routine. Currently only the
> +:c:macro:`MEI_EVENT_RX` event will trigger an event handler call and
> +the driver implementation is supposed to call :c:func:`mei_recv()` from
> +the event handler in order to fetch the pending received buffers.
> +
> +
> +Example
> +=======
> +
> +As a theoretical example let's pretend the ME comes with a "contact" NFC IP.
> +The driver init and exit routines for this device would look like:
> +
> +::
> +
> +        #define CONTACT_DRIVER_NAME "contact"
> +
> +        static struct mei_cl_device_id contact_mei_cl_tbl[] = {
> +	        { CONTACT_DRIVER_NAME, },
> +	        /* required last entry */
> +	        { }
> +        };
> +        MODULE_DEVICE_TABLE(mei_cl, contact_mei_cl_tbl);
> +
> +        static struct mei_cl_driver contact_driver = {
> +	        .id_table = contact_mei_tbl,
> +	        .name = CONTACT_DRIVER_NAME,
> +	        .probe = contact_probe,
> +	        .remove = contact_remove,
> +        };
> +
> +        static int contact_init(void)
> +        {
> +	        int r;
> +
> +	        r = mei_cl_driver_register(&contact_driver);
> +	        if (r) {
> +		        pr_err(CONTACT_DRIVER_NAME ": driver registration
> failed\n");
> +		        return r;
> +	        }
> +
> +	        return 0;
> +        }
> +
> +        static void __exit contact_exit(void)
> +        {
> +	        mei_cl_driver_unregister(&contact_driver);
> +        }
> +
> +        module_init(contact_init);
> +        module_exit(contact_exit);
> +
> +And the driver's simplified probe routine would look like that:
> +
> +::
> +
> +        int contact_probe(struct mei_cl_device *dev, struct mei_cl_device_id
> *id)
> +        {
> +	        struct contact_driver *contact;
> +
> +	        [...]
> +	        mei_cl_enable_device(dev);
> +
> +	        mei_cl_register_event_cb(dev, contact_event_cb, contact);
> +
> +	        return 0;
> +        }
> +
> +In the probe routine the driver first enable the MEI device and then
> +registers an ME bus event handler which is as close as it can get to
> +registering a threaded IRQ handler.
> +The handler implementation will typically call some I/O routine
> +depending on the pending events:
> +
> +::
> +
> +        #define MAX_NFC_PAYLOAD 128
> +
> +        static void contact_event_cb(struct mei_cl_device *dev, u32 events,
> +                                     void *context)
> +        {
> +	        struct contact_driver *contact = context;
> +
> +	        if (events & BIT(MEI_EVENT_RX)) {
> +		        u8 payload[MAX_NFC_PAYLOAD];
> +		        int payload_size;
> +
> +		        payload_size = mei_recv(dev, payload,
> MAX_NFC_PAYLOAD);
> +		        if (payload_size <= 0)
> +			        return;
> +
> +		        /* Hook to the NFC subsystem */
> +		        nfc_hci_recv_frame(contact->hdev, payload,
> payload_size);
> +	        }
> +        }
> diff --git a/Documentation/misc-devices/mei/mei-client-bus.txt
> b/Documentation/misc-devices/mei/mei-client-bus.txt
> deleted file mode 100644
> index 743be4ec8989..000000000000
> --- a/Documentation/misc-devices/mei/mei-client-bus.txt
> +++ /dev/null
> @@ -1,141 +0,0 @@
> -Intel(R) Management Engine (ME) Client bus API -
> ==============================================
> -
> -
> -Rationale
> -=========
> -
> -MEI misc character device is useful for dedicated applications to send and
> receive -data to the many FW appliance found in Intel's ME from the user
> space.
> -However for some of the ME functionalities it make sense to leverage existing
> software -stack and expose them through existing kernel subsystems.
> -
> -In order to plug seamlessly into the kernel device driver model we add kernel
> virtual -bus abstraction on top of the MEI driver. This allows implementing linux
> kernel drivers -for the various MEI features as a stand alone entities found in
> their respective subsystem.
> -Existing device drivers can even potentially be re-used by adding an MEI CL
> bus layer to -the existing code.
> -
> -
> -MEI CL bus API
> -==============
> -
> -A driver implementation for an MEI Client is very similar to existing bus -based
> device drivers. The driver registers itself as an MEI CL bus driver through -the
> mei_cl_driver structure:
> -
> -struct mei_cl_driver {
> -	struct device_driver driver;
> -	const char *name;
> -
> -	const struct mei_cl_device_id *id_table;
> -
> -	int (*probe)(struct mei_cl_device *dev, const struct mei_cl_id *id);
> -	int (*remove)(struct mei_cl_device *dev);
> -};
> -
> -struct mei_cl_id {
> -	char name[MEI_NAME_SIZE];
> -	kernel_ulong_t driver_info;
> -};
> -
> -The mei_cl_id structure allows the driver to bind itself against a device name.
> -
> -To actually register a driver on the ME Client bus one must call the
> mei_cl_add_driver() -API. This is typically called at module init time.
> -
> -Once registered on the ME Client bus, a driver will typically try to do some I/O
> on -this bus and this should be done through the mei_cl_send() and
> mei_cl_recv() -routines. The latter is synchronous (blocks and sleeps until data
> shows up).
> -In order for drivers to be notified of pending events waiting for them (e.g.
> -an Rx event) they can register an event handler through the
> -mei_cl_register_event_cb() routine. Currently only the MEI_EVENT_RX event -
> will trigger an event handler call and the driver implementation is supposed -to
> call mei_recv() from the event handler in order to fetch the pending -received
> buffers.
> -
> -
> -Example
> -=======
> -
> -As a theoretical example let's pretend the ME comes with a "contact" NFC IP.
> -The driver init and exit routines for this device would look like:
> -
> -#define CONTACT_DRIVER_NAME "contact"
> -
> -static struct mei_cl_device_id contact_mei_cl_tbl[] = {
> -	{ CONTACT_DRIVER_NAME, },
> -
> -	/* required last entry */
> -	{ }
> -};
> -MODULE_DEVICE_TABLE(mei_cl, contact_mei_cl_tbl);
> -
> -static struct mei_cl_driver contact_driver = {
> -	.id_table = contact_mei_tbl,
> -	.name = CONTACT_DRIVER_NAME,
> -
> -	.probe = contact_probe,
> -	.remove = contact_remove,
> -};
> -
> -static int contact_init(void)
> -{
> -	int r;
> -
> -	r = mei_cl_driver_register(&contact_driver);
> -	if (r) {
> -		pr_err(CONTACT_DRIVER_NAME ": driver registration
> failed\n");
> -		return r;
> -	}
> -
> -	return 0;
> -}
> -
> -static void __exit contact_exit(void)
> -{
> -	mei_cl_driver_unregister(&contact_driver);
> -}
> -
> -module_init(contact_init);
> -module_exit(contact_exit);
> -
> -And the driver's simplified probe routine would look like that:
> -
> -int contact_probe(struct mei_cl_device *dev, struct mei_cl_device_id *id) -{
> -	struct contact_driver *contact;
> -
> -	[...]
> -	mei_cl_enable_device(dev);
> -
> -	mei_cl_register_event_cb(dev, contact_event_cb, contact);
> -
> -	return 0;
> -}
> -
> -In the probe routine the driver first enable the MEI device and then registers -
> an ME bus event handler which is as close as it can get to registering a -
> threaded IRQ handler.
> -The handler implementation will typically call some I/O routine depending on -
> the pending events:
> -
> -#define MAX_NFC_PAYLOAD 128
> -
> -static void contact_event_cb(struct mei_cl_device *dev, u32 events,
> -			     void *context)
> -{
> -	struct contact_driver *contact = context;
> -
> -	if (events & BIT(MEI_EVENT_RX)) {
> -		u8 payload[MAX_NFC_PAYLOAD];
> -		int payload_size;
> -
> -		payload_size = mei_recv(dev, payload, MAX_NFC_PAYLOAD);
> -		if (payload_size <= 0)
> -			return;
> -
> -		/* Hook to the NFC subsystem */
> -		nfc_hci_recv_frame(contact->hdev, payload, payload_size);
> -	}
> -}
> diff --git a/Documentation/misc-devices/mei/mei.rst b/Documentation/misc-
> devices/mei/mei.rst
> new file mode 100644
> index 000000000000..e91ac2570b4d
> --- /dev/null
> +++ b/Documentation/misc-devices/mei/mei.rst
> @@ -0,0 +1,289 @@
> +.. SPDX-License-Identifier: GPL-2.0
> +
> +====================================
> +Intel(R) Management Engine Interface
> +====================================
> +
> +Introduction
> +============
> +
> +The Intel Management Engine (Intel ME) is an isolated and protected
> +computing resource (Co-processor) residing inside certain Intel
> +chipsets. The Intel ME provides support for computer/IT management
> +features. The feature set depends on the Intel chipset SKU.
> +
> +The Intel Management Engine Interface (Intel MEI, previously known as
> +HECI) is the interface between the Host and Intel ME. This interface is
> +exposed to the host as a PCI device. The Intel MEI Driver is in charge
> +of the communication channel between a host application and the Intel ME
> feature.
> +
> +Each Intel ME feature (Intel ME Client) is addressed by a GUID/UUID and
> +each client has its own protocol. The protocol is message-based with a
> +header and payload up to 512 bytes.
> +
> +Prominent usage of the Intel ME Interface is to communicate with
> +Intel(R) Active Management Technology (Intel AMT) implemented in
> +firmware running on the Intel ME.
> +
> +Intel AMT provides the ability to manage a host remotely out-of-band
> +(OOB) even when the operating system running on the host processor has
> +crashed or is in a sleep state.
> +
> +Some examples of Intel AMT usage are:
> +        * Monitoring hardware state and platform components
> +        * Remote power off/on (useful for green computing or overnight IT
> +          maintenance)
> +        * OS updates
> +        * Storage of useful platform information such as software assets
> +        * Built-in hardware KVM
> +        * Selective network isolation of Ethernet and IP protocol flows based
> +          on policies set by a remote management console
> +        * IDE device redirection from remote management console
> +
> +Intel AMT (OOB) communication is based on SOAP (deprecated starting
> +with Release 6.0) over HTTP/S or WS-Management protocol over HTTP/S
> +that are received from a remote management console application.
> +
> +For more information about Intel AMT:
> +`<http://software.intel.com/sites/manageability/AMT_Implementation_and_
> +Reference_Guide>`_
> +
> +
> +Intel MEI Driver
> +================
> +
> +The driver exposes a misc device called :file:`/dev/mei`.
> +
> +An application maintains communication with an Intel ME feature while
> +:file:`/dev/mei` is open. The binding to a specific feature is
> +performed by calling :c:macro:`IOCTL_MEI_CONNECT_CLIENT`, which passes
> the desired UUID.
> +The number of instances of an Intel ME feature that can be opened at
> +the same time depends on the Intel ME feature, but most of the features
> +allow only a single instance.
> +
> +The Intel AMT Host Interface (Intel AMTHI) feature supports multiple
> +simultaneous user connected applications. The Intel MEI driver handles
> +this internally by maintaining request queues for the applications.
> +
> +The driver is transparent to data that are passed between firmware
> +feature and host application.
> +
> +Because some of the Intel ME features can change the system
> +configuration, the driver by default allows only a privileged user to
> +access it.
> +
> +A code snippet for an application communicating with Intel AMTHI client:
> +
> +::
> +
> +        struct mei_connect_client_data data;
> +        fd = open(MEI_DEVICE);
> +
> +        data.d.in_client_uuid = AMTHI_UUID;
> +
> +        ioctl(fd, IOCTL_MEI_CONNECT_CLIENT, &data);
> +
> +        printf("Ver=%d, MaxLen=%ld\n",
> +               data.d.in_client_uuid.protocol_version,
> +               data.d.in_client_uuid.max_msg_length);
> +
> +        [...]
> +
> +        write(fd, amthi_req_data, amthi_req_data_len);
> +
> +        [...]
> +
> +        read(fd, &amthi_res_data, amthi_res_data_len);
> +
> +        [...]
> +
> +        close(fd);
> +
> +
> +IOCTL
> +=====
> +
> +The Intel MEI Driver supports the following IOCTL commands:
> +
> +
> +:c:macro:`IOCTL_MEI_CONNECT_CLIENT`
> +-------------------------------------
> +Connect to firmware Feature (client)
> +
> +**Usage:**
> +
> +::
> +
> +        struct mei_connect_client_data clientData;
> +        ioctl(fd, IOCTL_MEI_CONNECT_CLIENT, &clientData);
> +
> +**Inputs:**
> +        :c:type:`mei_connect_client_data` - structure contain the following
> +        input field.
> +
> +        :c:data:`in_client_uuid` - UUID of the FW Feature that needs to connect
> to.
> +
> +**Outputs:**
> +        :c:data:`out_client_properties` - Client Properties: MTU and Protocol
> Version.
> +
> +**Error returns:**
> +        | :c:macro:`EINVAL` -  Wrong IOCTL Number.
> +        | :c:macro:`ENODEV` -  Device or Connection is not initialized or ready.
> (e.g. Wrong UUID).
> +        | :c:macro:`ENOMEM` - Unable to allocate memory to client internal
> data.
> +        | :c:macro:`EFAULT` -  Fatal Error (e.g. Unable to access user input data).
> +        | :c:macro:`EBUSY` -  Connection Already Open.
> +
> +**Notes:**
> +        :c:data:`max_msg_length` (MTU) in client properties describes the
> maximum
> +        data that can be sent or received. (e.g. if MTU=2K, can send
> +        requests up to bytes 2k and received responses up to 2k bytes).
> +
> +
> +:c:macro:`IOCTL_MEI_NOTIFY_SET`
> +-------------------------------
> +Enable or disable event notifications
> +
> +**Usage:**
> +
> +::
> +
> +        uint32_t enable;
> +        ioctl(fd, IOCTL_MEI_NOTIFY_SET, &enable);
> +
> +**Inputs:**
> +        | :c:data:`uint32_t enable = 1;`
> +        | or
> +        | :c:data:`uint32_t enable[disable] = 0;`
> +
> +**Error returns:**
> +        | :c:macro:`EINVAL` - Wrong IOCTL Number.
> +        | :c:macro:`ENODEV` - Device  is not initialized or the client not
> connected.
> +        | :c:macro:`ENOMEM` - Unable to allocate memory to client internal
> data.
> +        | :c:macro:`EFAULT` - Fatal Error (e.g. Unable to access user input data).
> +        | :c:macro:`EOPNOTSUPP` - if the device doesn't support the feature.
> +
> +**Notes:**
> +        The client must be connected in order to enable notification events.
> +
> +
> +:c:macro:`IOCTL_MEI_NOTIFY_GET`
> +-------------------------------
> +Retrieve event
> +
> +**Usage:**
> +
> +::
> +
> +        uint32_t event;
> +        ioctl(fd, IOCTL_MEI_NOTIFY_GET, &event);
> +
> +**Outputs:**
> +        | 1 - if an event is pending.
> +        | 0 - if there is no even pending.
> +
> +**Error returns:**
> +        | :c:macro:`EINVAL` - Wrong IOCTL Number.
> +        | :c:macro:`ENODEV` - Device is not initialized or the client not
> connected.
> +        | :c:macro:`ENOMEM` - Unable to allocate memory to client internal
> data.
> +        | :c:macro:`EFAULT` - Fatal Error (e.g. Unable to access user input data).
> +        | :c:macro:`EOPNOTSUPP` - if the device doesn't support the feature.
> +
> +**Notes:**
> +        The client must be connected and event notification has to be enabled
> +        in order to receive an event.
> +
> +
> +Intel ME Applications
> +=====================
> +
> +1) Intel Local Management Service (Intel LMS)
> +
> +        Applications running locally on the platform communicate with Intel AMT
> Release
> +        2.0 and later releases in the same way that network applications do via
> SOAP
> +        over HTTP (deprecated starting with Release 6.0) or with WS-
> Management over
> +        SOAP over HTTP. This means that some Intel AMT features can be
> accessed from a
> +        local application using the same network interface as a remote
> application
> +        communicating with Intel AMT over the network.
> +
> +        When a local application sends a message addressed to the local Intel
> AMT host
> +        name, the Intel LMS, which listens for traffic directed to the host name,
> +        intercepts the message and routes it to the Intel MEI.
> +        For more information:
> +
> `<http://software.intel.com/sites/manageability/AMT_Implementation_and_Re
> ference_Guide>`_
> +        Under "About Intel AMT" => "Local Access"
> +
> +        For downloading Intel LMS:
> +
> + `<http://software.intel.com/en-us/articles/download-the-latest-intel-a
> + mt-open-source-drivers/>`_
> +
> +        The Intel LMS opens a connection using the Intel MEI driver to the Intel
> LMS
> +        firmware feature using a defined UUID and then communicates with the
> feature
> +        using a protocol called Intel AMT Port Forwarding Protocol (Intel APF
> protocol).
> +        The protocol is used to maintain multiple sessions with Intel AMT from a
> +        single application.
> +
> +        See the protocol specification in the `Intel AMT Software Development
> Kit (SDK)
> +
> <http://software.intel.com/sites/manageability/AMT_Implementation_and_Ref
> erence_Guide>`_
> +        Under "SDK Resources" => "Intel(R) vPro(TM) Gateway (MPS)"
> +        => "Information for Intel(R) vPro(TM) Gateway Developers"
> +        => "Description of the Intel AMT Port Forwarding (APF) Protocol"
> +
> +2) Intel AMT Remote configuration using a Local Agent
> +
> +        A Local Agent enables IT personnel to configure Intel AMT out-of-the-box
> +        without requiring installing additional data to enable setup. The remote
> +        configuration process may involve an ISV-developed remote
> configuration
> +        agent that runs on the host.
> +        For more information:
> +
> `<http://software.intel.com/sites/manageability/AMT_Implementation_and_Re
> ference_Guide>`_
> +        Under "Setup and Configuration of Intel AMT" =>
> +        "SDK Tools Supporting Setup and Configuration" =>
> +        "Using the Local Agent Sample"
> +
> +        An open source Intel AMT configuration utility,	implementing a local
> agent
> +        that accesses the Intel MEI driver, can be found here:
> +
> + `<http://software.intel.com/en-us/articles/download-the-latest-intel-a
> + mt-open-source-drivers/>`
> +
> +
> +Intel AMT OS Health Watchdog
> +============================
> +
> +The Intel AMT Watchdog is an OS Health (Hang/Crash) watchdog.
> +Whenever the OS hangs or crashes, Intel AMT will send an event to any
> +subscriber to this event. This mechanism means that IT knows when a
> +platform crashes even when there is a hard failure on the host.
> +
> +The Intel AMT Watchdog is composed of two parts:
> +        1) Firmware feature - receives the heartbeats
> +           and sends an event when the heartbeats stop.
> +        2) Intel MEI iAMT watchdog driver - connects to the watchdog feature,
> +           configures the watchdog and sends the heartbeats.
> +
> +The Intel iAMT watchdog MEI driver uses the kernel watchdog API to
> +configure the Intel AMT Watchdog and to send heartbeats to it. The
> +default timeout of the watchdog is 120 seconds.
> +
> +If the Intel AMT is not enabled in the firmware then the watchdog
> +client won't enumerate on the me client bus and watchdog devices won't be
> exposed.
> +
> +
> +Supported Chipsets
> +==================
> +
> +| 7 Series Chipset Family
> +| 6 Series Chipset Family
> +| 5 Series Chipset Family
> +| 4 Series Chipset Family
> +| Mobile 4 Series Chipset Family
> +| ICH9
> +| 82946GZ/GL
> +| 82G35 Express
> +| 82Q963/Q965
> +| 82P965/G965
> +| Mobile PM965/GM965
> +| Mobile GME965/GLE960
> +| 82Q35 Express
> +| 82G33/G31/P35/P31 Express
> +| 82Q33 Express
> +| 82X38/X48 Express
> +
> +---
> +linux-mei@linux.intel.com
> diff --git a/Documentation/misc-devices/mei/mei.txt b/Documentation/misc-
> devices/mei/mei.txt
> deleted file mode 100644
> index 2b80a0cd621f..000000000000
> --- a/Documentation/misc-devices/mei/mei.txt
> +++ /dev/null
> @@ -1,266 +0,0 @@
> -Intel(R) Management Engine Interface (Intel(R) MEI) -
> ===================================================
> -
> -Introduction
> -============
> -
> -The Intel Management Engine (Intel ME) is an isolated and protected
> computing -resource (Co-processor) residing inside certain Intel chipsets. The
> Intel ME -provides support for computer/IT management features. The feature
> set -depends on the Intel chipset SKU.
> -
> -The Intel Management Engine Interface (Intel MEI, previously known as HECI)
> -is the interface between the Host and Intel ME. This interface is exposed -to
> the host as a PCI device. The Intel MEI Driver is in charge of the -
> communication channel between a host application and the Intel ME feature.
> -
> -Each Intel ME feature (Intel ME Client) is addressed by a GUID/UUID and -each
> client has its own protocol. The protocol is message-based with a -header and
> payload up to 512 bytes.
> -
> -Prominent usage of the Intel ME Interface is to communicate with Intel(R) -
> Active Management Technology (Intel AMT) implemented in firmware running
> on -the Intel ME.
> -
> -Intel AMT provides the ability to manage a host remotely out-of-band (OOB) -
> even when the operating system running on the host processor has crashed or -
> is in a sleep state.
> -
> -Some examples of Intel AMT usage are:
> -   - Monitoring hardware state and platform components
> -   - Remote power off/on (useful for green computing or overnight IT
> -     maintenance)
> -   - OS updates
> -   - Storage of useful platform information such as software assets
> -   - Built-in hardware KVM
> -   - Selective network isolation of Ethernet and IP protocol flows based
> -     on policies set by a remote management console
> -   - IDE device redirection from remote management console
> -
> -Intel AMT (OOB) communication is based on SOAP (deprecated -starting with
> Release 6.0) over HTTP/S or WS-Management protocol over -HTTP/S that are
> received from a remote management console application.
> -
> -For more information about Intel AMT:
> -
> http://software.intel.com/sites/manageability/AMT_Implementation_and_Refe
> rence_Guide
> -
> -
> -Intel MEI Driver
> -================
> -
> -The driver exposes a misc device called /dev/mei.
> -
> -An application maintains communication with an Intel ME feature while -
> /dev/mei is open. The binding to a specific feature is performed by calling -
> MEI_CONNECT_CLIENT_IOCTL, which passes the desired UUID.
> -The number of instances of an Intel ME feature that can be opened -at the
> same time depends on the Intel ME feature, but most of the -features allow
> only a single instance.
> -
> -The Intel AMT Host Interface (Intel AMTHI) feature supports multiple -
> simultaneous user connected applications. The Intel MEI driver -handles this
> internally by maintaining request queues for the applications.
> -
> -The driver is transparent to data that are passed between firmware feature -
> and host application.
> -
> -Because some of the Intel ME features can change the system -configuration,
> the driver by default allows only a privileged -user to access it.
> -
> -A code snippet for an application communicating with Intel AMTHI client:
> -
> -	struct mei_connect_client_data data;
> -	fd = open(MEI_DEVICE);
> -
> -	data.d.in_client_uuid = AMTHI_UUID;
> -
> -	ioctl(fd, IOCTL_MEI_CONNECT_CLIENT, &data);
> -
> -	printf("Ver=%d, MaxLen=%ld\n",
> -			data.d.in_client_uuid.protocol_version,
> -			data.d.in_client_uuid.max_msg_length);
> -
> -	[...]
> -
> -	write(fd, amthi_req_data, amthi_req_data_len);
> -
> -	[...]
> -
> -	read(fd, &amthi_res_data, amthi_res_data_len);
> -
> -	[...]
> -	close(fd);
> -
> -
> -IOCTL
> -=====
> -
> -The Intel MEI Driver supports the following IOCTL commands:
> -	IOCTL_MEI_CONNECT_CLIENT	Connect to firmware Feature (client).
> -
> -	usage:
> -		struct mei_connect_client_data clientData;
> -		ioctl(fd, IOCTL_MEI_CONNECT_CLIENT, &clientData);
> -
> -	inputs:
> -		mei_connect_client_data struct contain the following
> -		input field:
> -
> -		in_client_uuid -	UUID of the FW Feature that needs
> -					to connect to.
> -	outputs:
> -		out_client_properties - Client Properties: MTU and Protocol
> Version.
> -
> -	error returns:
> -		EINVAL	Wrong IOCTL Number
> -		ENODEV	Device or Connection is not initialized or
> ready.
> -			(e.g. Wrong UUID)
> -		ENOMEM	Unable to allocate memory to client internal
> data.
> -		EFAULT	Fatal Error (e.g. Unable to access user input data)
> -		EBUSY	Connection Already Open
> -
> -	Notes:
> -        max_msg_length (MTU) in client properties describes the maximum
> -        data that can be sent or received. (e.g. if MTU=2K, can send
> -        requests up to bytes 2k and received responses up to 2k bytes).
> -
> -	IOCTL_MEI_NOTIFY_SET: enable or disable event notifications
> -
> -	Usage:
> -		uint32_t enable;
> -		ioctl(fd, IOCTL_MEI_NOTIFY_SET, &enable);
> -
> -	Inputs:
> -		uint32_t enable = 1;
> -		or
> -		uint32_t enable[disable] = 0;
> -
> -	Error returns:
> -		EINVAL	Wrong IOCTL Number
> -		ENODEV	Device  is not initialized or the client not
> connected
> -		ENOMEM	Unable to allocate memory to client internal
> data.
> -		EFAULT	Fatal Error (e.g. Unable to access user input data)
> -		EOPNOTSUPP if the device doesn't support the feature
> -
> -	Notes:
> -	The client must be connected in order to enable notification events
> -
> -
> -	IOCTL_MEI_NOTIFY_GET : retrieve event
> -
> -	Usage:
> -		uint32_t event;
> -		ioctl(fd, IOCTL_MEI_NOTIFY_GET, &event);
> -
> -	Outputs:
> -		1 - if an event is pending
> -		0 - if there is no even pending
> -
> -	Error returns:
> -		EINVAL	Wrong IOCTL Number
> -		ENODEV	Device is not initialized or the client not
> connected
> -		ENOMEM	Unable to allocate memory to client internal
> data.
> -		EFAULT	Fatal Error (e.g. Unable to access user input data)
> -		EOPNOTSUPP if the device doesn't support the feature
> -
> -	Notes:
> -	The client must be connected and event notification has to be enabled
> -	in order to receive an event
> -
> -
> -Intel ME Applications
> -=====================
> -
> -	1) Intel Local Management Service (Intel LMS)
> -
> -	   Applications running locally on the platform communicate with Intel
> AMT Release
> -	   2.0 and later releases in the same way that network applications do
> via SOAP
> -	   over HTTP (deprecated starting with Release 6.0) or with WS-
> Management over
> -	   SOAP over HTTP. This means that some Intel AMT features can be
> accessed from a
> -	   local application using the same network interface as a remote
> application
> -	   communicating with Intel AMT over the network.
> -
> -	   When a local application sends a message addressed to the local Intel
> AMT host
> -	   name, the Intel LMS, which listens for traffic directed to the host
> name,
> -	   intercepts the message and routes it to the Intel MEI.
> -	   For more information:
> -
> http://software.intel.com/sites/manageability/AMT_Implementation_and_Refe
> rence_Guide
> -	   Under "About Intel AMT" => "Local Access"
> -
> -	   For downloading Intel LMS:
> -	   http://software.intel.com/en-us/articles/download-the-latest-intel-
> amt-open-source-drivers/
> -
> -	   The Intel LMS opens a connection using the Intel MEI driver to the
> Intel LMS
> -	   firmware feature using a defined UUID and then communicates with
> the feature
> -	   using a protocol called Intel AMT Port Forwarding Protocol (Intel APF
> protocol).
> -	   The protocol is used to maintain multiple sessions with Intel AMT
> from a
> -	   single application.
> -
> -	   See the protocol specification in the Intel AMT Software Development
> Kit (SDK)
> -
> http://software.intel.com/sites/manageability/AMT_Implementation_and_Refe
> rence_Guide
> -	   Under "SDK Resources" => "Intel(R) vPro(TM) Gateway (MPS)"
> -	   => "Information for Intel(R) vPro(TM) Gateway Developers"
> -	   => "Description of the Intel AMT Port Forwarding (APF) Protocol"
> -
> -	2) Intel AMT Remote configuration using a Local Agent
> -
> -	   A Local Agent enables IT personnel to configure Intel AMT out-of-the-
> box
> -	   without requiring installing additional data to enable setup. The
> remote
> -	   configuration process may involve an ISV-developed remote
> configuration
> -	   agent that runs on the host.
> -	   For more information:
> -
> http://software.intel.com/sites/manageability/AMT_Implementation_and_Refe
> rence_Guide
> -	   Under "Setup and Configuration of Intel AMT" =>
> -	   "SDK Tools Supporting Setup and Configuration" =>
> -	   "Using the Local Agent Sample"
> -
> -	   An open source Intel AMT configuration utility,	implementing a local
> agent
> -	   that accesses the Intel MEI driver, can be found here:
> -	   http://software.intel.com/en-us/articles/download-the-latest-intel-
> amt-open-source-drivers/
> -
> -
> -Intel AMT OS Health Watchdog
> -============================
> -
> -The Intel AMT Watchdog is an OS Health (Hang/Crash) watchdog.
> -Whenever the OS hangs or crashes, Intel AMT will send an event -to any
> subscriber to this event. This mechanism means that -IT knows when a platform
> crashes even when there is a hard failure on the host.
> -
> -The Intel AMT Watchdog is composed of two parts:
> -	1) Firmware feature - receives the heartbeats
> -	   and sends an event when the heartbeats stop.
> -	2) Intel MEI iAMT watchdog driver - connects to the watchdog feature,
> -	   configures the watchdog and sends the heartbeats.
> -
> -The Intel iAMT watchdog MEI driver uses the kernel watchdog API to configure
> -the Intel AMT Watchdog and to send heartbeats to it. The default timeout of
> the -watchdog is 120 seconds.
> -
> -If the Intel AMT is not enabled in the firmware then the watchdog client won't
> enumerate -on the me client bus and watchdog devices won't be exposed.
> -
> -
> -Supported Chipsets
> -==================
> -
> -7 Series Chipset Family
> -6 Series Chipset Family
> -5 Series Chipset Family
> -4 Series Chipset Family
> -Mobile 4 Series Chipset Family
> -ICH9
> -82946GZ/GL
> -82G35 Express
> -82Q963/Q965
> -82P965/G965
> -Mobile PM965/GM965
> -Mobile GME965/GLE960
> -82Q35 Express
> -82G33/G31/P35/P31 Express
> -82Q33 Express
> -82X38/X48 Express
> -
> ----
> -linux-mei@linux.intel.com
> --
> 2.17.1

