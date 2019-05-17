Return-Path: <SRS0=M1fl=TR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7CCF0C04AB4
	for <linux-kernel@archiver.kernel.org>; Fri, 17 May 2019 13:37:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4CC55204FD
	for <linux-kernel@archiver.kernel.org>; Fri, 17 May 2019 13:37:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="e3fMuHrY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729021AbfEQNhg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 May 2019 09:37:36 -0400
Received: from hqemgate14.nvidia.com ([216.228.121.143]:8920 "EHLO
        hqemgate14.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728464AbfEQNhg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 May 2019 09:37:36 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqemgate14.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5cdeb9240001>; Fri, 17 May 2019 06:37:40 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Fri, 17 May 2019 06:37:34 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Fri, 17 May 2019 06:37:34 -0700
Received: from [10.19.120.147] (10.124.1.5) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Fri, 17 May
 2019 13:37:31 +0000
Subject: Re: [PATCH v10 1/2] usb: xhci : Add devaddr in struct usb_device
To:     Alan Stern <stern@rowland.harvard.edu>
References: <Pine.LNX.4.44L0.1905161054250.1280-100000@iolanthe.rowland.org>
CC:     <gregkh@linuxfoundation.org>, <mathias.nyman@intel.com>,
        <kai.heng.feng@canonical.com>, <drinkcat@chromium.org>,
        <keescook@chromium.org>, <nsaenzjulienne@suse.de>,
        <jflat@chromium.org>, <malat@debian.org>,
        <linux-usb@vger.kernel.org>, <linux-kernel@vger.kernel.org>
From:   Jim Lin <jilin@nvidia.com>
Message-ID: <63b291c6-b7bc-7796-412e-03f151d1b1a0@nvidia.com>
Date:   Fri, 17 May 2019 21:37:22 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.2.0
MIME-Version: 1.0
In-Reply-To: <Pine.LNX.4.44L0.1905161054250.1280-100000@iolanthe.rowland.org>
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL108.nvidia.com (172.18.146.13) To
 HQMAIL107.nvidia.com (172.20.187.13)
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: quoted-printable
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1558100261; bh=N0Nend43fiGw+jZLFyUCiqfXhdL3evNRULYfXIR/Y9M=;
        h=X-PGP-Universal:Subject:To:References:CC:From:Message-ID:Date:
         User-Agent:MIME-Version:In-Reply-To:X-Originating-IP:
         X-ClientProxiedBy:Content-Type:Content-Transfer-Encoding;
        b=e3fMuHrYyRfTrVd/+zJS9bL3Qk4s5pZTD28Cymw2Q7X/TA42ZJzAgvTd8ZYSQ2ODD
         DtcIVd7X+CFEEMe+ZQDEELtKFfgOyJKPCDqcDuEFDLh5tLFcKAl83Hmbb+oXZs6nQe
         P0qDQLmE+vsmXTyZuuUgO8II4U1Jj2b8pInTpBt8zFFTdvGNk5hzpJey/xAjX8CGnU
         PDnkgR8M9jfl6HMiYJU97DH8qpJmYxHwuSmP4x+2cX8kZC/r2mCbZky5AGoaBE3kaq
         B9GQGQ1LY7w6b5hLts2h5pA8T9XUKdM6Lkj33MbjRxsyqX7m7BBy20nfs2AD3ij20R
         u6TD6BgiS38OQ==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sorry, something went wrong.

The result is not as expected in one of the tests.

Abandon this series of patches.

Will debug and resubmit later.


Jim


On 2019=E5=B9=B405=E6=9C=8816=E6=97=A5 22:56, Alan Stern wrote:
> On Thu, 16 May 2019, Jim Lin wrote:
>
>> The Clear_TT_Buffer request sent to the hub includes the address of
>> the LS/FS child device in wValue field. usb_hub_clear_tt_buffer()
>> uses udev->devnum to set the address wValue. This won't work for
>> devices connected to xHC.
>>
>> For other host controllers udev->devnum is the same as the address of
>> the usb device, chosen and set by usb core. With xHC the controller
>> hardware assigns the address, and won't be the same as devnum.
>>
>> Here we add devaddr in "struct usb_device" for
>> usb_hub_clear_tt_buffer() to use.
>>
>> Signed-off-by: Jim Lin <jilin@nvidia.com>
>> ---
> Aside from the "xhci:" part of the Subject line (it's not really
> appropriate because this is a modification of the USB core more than of
> the xhci-hcd driver),
>
> Acked-by: Alan Stern <stern@rowland.harvard.edu>
>
>
>> v2: xhci_clear_tt_buffer_complete: add static, shorter indentation
>>      , remove its claiming in xhci.h
>> v3: Add description for clearing_tt (xhci.h)
>> v4: Remove clearing_tt flag because hub_tt_work has hub->tt.lock
>>      to protect for Clear_TT_Buffer to be run serially.
>>      Remove xhci_clear_tt_buffer_complete as it's not necessary.
>>      Same reason as the above.
>>      Extend usb_hub_clear_tt_buffer parameter
>> v5: Not extending usb_hub_clear_tt_buffer parameter
>>      Add description.
>> v6: Remove unused parameter slot_id from xhci_clear_hub_tt_buffer
>> v7: Add devaddr field in "struct usb_device"
>> v8: split as two patches, change type from int to u8 for devaddr.
>> v9: Use pahole to find place to put devaddr in struct usb_device.
>>      Remove space between type cast and variable.
>>      hub.c changed from v8
>>      clear->devinfo |=3D (u16) (udev->devaddr << 4);
>>      to
>>      clear->devinfo |=3D ((u16)udev->devaddr) << 4;
>>      to solve a problem if devaddr is larger than 16.
>> v10 Initialize devaddr in xhci_setup_device()
>>      Move devaddr to be below "u8 level"
>>
>>   drivers/usb/core/hub.c  | 4 +++-
>>   drivers/usb/host/xhci.c | 1 +
>>   include/linux/usb.h     | 2 ++
>>   3 files changed, 6 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/usb/core/hub.c b/drivers/usb/core/hub.c
>> index 15a2934dc29d..0d4b289be103 100644
>> --- a/drivers/usb/core/hub.c
>> +++ b/drivers/usb/core/hub.c
>> @@ -873,7 +873,7 @@ int usb_hub_clear_tt_buffer(struct urb *urb)
>>   	/* info that CLEAR_TT_BUFFER needs */
>>   	clear->tt =3D tt->multi ? udev->ttport : 1;
>>   	clear->devinfo =3D usb_pipeendpoint (pipe);
>> -	clear->devinfo |=3D udev->devnum << 4;
>> +	clear->devinfo |=3D ((u16)udev->devaddr) << 4;
>>   	clear->devinfo |=3D usb_pipecontrol(pipe)
>>   			? (USB_ENDPOINT_XFER_CONTROL << 11)
>>   			: (USB_ENDPOINT_XFER_BULK << 11);
>> @@ -2125,6 +2125,8 @@ static void update_devnum(struct usb_device *udev,=
 int devnum)
>>   	/* The address for a WUSB device is managed by wusbcore. */
>>   	if (!udev->wusb)
>>   		udev->devnum =3D devnum;
>> +	if (!udev->devaddr)
>> +		udev->devaddr =3D (u8)devnum;
>>   }
>>  =20
>>   static void hub_free_dev(struct usb_device *udev)
>> diff --git a/drivers/usb/host/xhci.c b/drivers/usb/host/xhci.c
>> index 7fa58c99f126..68b393e5a453 100644
>> --- a/drivers/usb/host/xhci.c
>> +++ b/drivers/usb/host/xhci.c
>> @@ -4096,6 +4096,7 @@ static int xhci_setup_device(struct usb_hcd *hcd, =
struct usb_device *udev,
>>   	/* Zero the input context control for later use */
>>   	ctrl_ctx->add_flags =3D 0;
>>   	ctrl_ctx->drop_flags =3D 0;
>> +	udev->devaddr =3D (u8)(le32_to_cpu(slot_ctx->dev_state) & DEV_ADDR_MAS=
K);
>>  =20
>>   	xhci_dbg_trace(xhci, trace_xhci_dbg_address,
>>   		       "Internal device address =3D %d",
>> diff --git a/include/linux/usb.h b/include/linux/usb.h
>> index 4229eb74bd2c..af68e31118f8 100644
>> --- a/include/linux/usb.h
>> +++ b/include/linux/usb.h
>> @@ -580,6 +580,7 @@ struct usb3_lpm_parameters {
>>    * @bus_mA: Current available from the bus
>>    * @portnum: parent port number (origin 1)
>>    * @level: number of USB hub ancestors
>> + * @devaddr: device address, XHCI: assigned by HW, others: same as devn=
um
>>    * @can_submit: URBs may be submitted
>>    * @persist_enabled:  USB_PERSIST enabled for this device
>>    * @have_langid: whether string_langid is valid
>> @@ -663,6 +664,7 @@ struct usb_device {
>>   	unsigned short bus_mA;
>>   	u8 portnum;
>>   	u8 level;
>> +	u8 devaddr;
>>  =20
>>   	unsigned can_submit:1;
>>   	unsigned persist_enabled:1;
>>

