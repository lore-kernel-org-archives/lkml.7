Return-Path: <SRS0=GVTe=2R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6ACCDC2D0DB
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Dec 2019 07:04:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4013920CC7
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Dec 2019 07:04:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="aFBgSR0n"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726605AbfL0HEG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Dec 2019 02:04:06 -0500
Received: from hqnvemgate25.nvidia.com ([216.228.121.64]:5297 "EHLO
        hqnvemgate25.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725904AbfL0HEG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Dec 2019 02:04:06 -0500
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate25.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5e05acd70001>; Thu, 26 Dec 2019 23:03:51 -0800
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Thu, 26 Dec 2019 23:04:04 -0800
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Thu, 26 Dec 2019 23:04:04 -0800
Received: from [10.24.192.96] (10.124.1.5) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Fri, 27 Dec
 2019 07:04:00 +0000
Subject: Re: [Patch V2 04/18] phy: tegra: xusb: Add usb-phy support
To:     Thierry Reding <thierry.reding@gmail.com>
CC:     <balbi@kernel.org>, <gregkh@linuxfoundation.org>,
        <jonathanh@nvidia.com>, <mark.rutland@arm.com>,
        <robh+dt@kernel.org>, <kishon@ti.com>,
        <devicetree@vger.kernel.org>, <linux-tegra@vger.kernel.org>,
        <linux-usb@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <1576660591-10383-1-git-send-email-nkristam@nvidia.com>
 <1576660591-10383-5-git-send-email-nkristam@nvidia.com>
 <20191219133707.GK1440537@ulmo>
X-Nvconfidentiality: public
From:   Nagarjuna Kristam <nkristam@nvidia.com>
Message-ID: <e55136cf-db2b-1305-2c21-3d003a0218df@nvidia.com>
Date:   Fri, 27 Dec 2019 12:36:05 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.1
MIME-Version: 1.0
In-Reply-To: <20191219133707.GK1440537@ulmo>
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL101.nvidia.com (172.20.187.10) To
 HQMAIL107.nvidia.com (172.20.187.13)
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1577430231; bh=xsLSRJX1IFwbNRIvbyRAWl3iav/KcRoDlcSw8QJ+O4Q=;
        h=X-PGP-Universal:Subject:To:CC:References:X-Nvconfidentiality:From:
         Message-ID:Date:User-Agent:MIME-Version:In-Reply-To:
         X-Originating-IP:X-ClientProxiedBy:Content-Type:Content-Language:
         Content-Transfer-Encoding;
        b=aFBgSR0nDHQo9G3qvRO+eyedVobvBwOqNyvROG7xihnw0O24R0V10UHNvDPDnupCx
         9ZKdj262A8ETfQ5wLqv3m7AfhoIe7zTEjIhfrjiOxJDBSxjClnVWOoeVHOeZH4LeFJ
         fw5hWRVnk3GW5NY4/nVd1wOvH+zPRfhDRuWpB7tYGaL6ZKtowKX6JrPDX7k2wnjZO0
         YBOAnKA2lUpKffjsLUDwi0yklFV11TGyH7J6+GhbPrPauI6YGeteGBdpaK0vMzO+BN
         NDH2MpXIBG5NU6SA+V9f+8SIdOpmQjmj5Yi7L/aQmjN7SByREwAdL8QdWSSfhwWgqg
         lhlNc+gbZNdIg==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 19-12-2019 19:07, Thierry Reding wrote:
> On Wed, Dec 18, 2019 at 02:46:17PM +0530, Nagarjuna Kristam wrote:
>> For USB 2 ports that has usb-role-switch enabled, add usb-phy for
>> corresponding USB 2 phy. USB role changes from role switch are then
>> updated to corresponding host and device mode drivers via usb-phy notifier
>> block.
>>
>> Signed-off-by: Nagarjuna Kristam<nkristam@nvidia.com>
>> ---
>> V2:
>>   - Added dev_set_drvdata for port->dev.
>> ---
>>   drivers/phy/tegra/xusb.c | 71 ++++++++++++++++++++++++++++++++++++++++++++++++
>>   drivers/phy/tegra/xusb.h |  2 ++
>>   2 files changed, 73 insertions(+)
>>
>> diff --git a/drivers/phy/tegra/xusb.c b/drivers/phy/tegra/xusb.c
>> index dc00b42..5bde8f1 100644
>> --- a/drivers/phy/tegra/xusb.c
>> +++ b/drivers/phy/tegra/xusb.c
>> @@ -533,6 +533,8 @@ static int tegra_xusb_port_init(struct tegra_xusb_port *port,
>>   	if (err < 0)
>>   		goto unregister;
>>   
>> +	dev_set_drvdata(&port->dev, port);
>> +
>>   	return 0;
>>   
>>   unregister:
>> @@ -545,6 +547,8 @@ static void tegra_xusb_port_unregister(struct tegra_xusb_port *port)
>>   	if (!IS_ERR_OR_NULL(port->usb_role_sw)) {
>>   		of_platform_depopulate(&port->dev);
>>   		usb_role_switch_unregister(port->usb_role_sw);
>> +		cancel_work_sync(&port->usb_phy_work);
>> +		usb_remove_phy(&port->usb_phy);
>>   	}
>>   	device_unregister(&port->dev);
>>   }
>> @@ -556,16 +560,59 @@ static const char *const modes[] = {
>>   	[USB_DR_MODE_OTG] = "otg",
>>   };
>>   
>> +static void tegra_xusb_usb_phy_work(struct work_struct *work)
>> +{
>> +	struct tegra_xusb_port *port = container_of(work,
>> +				struct tegra_xusb_port, usb_phy_work);
> Perhaps add a static inline function to cast this? Might not be worth it
> since we only need to cast once. In that case, perhaps make this look a
> little prettier by aligning arguments on subsequent lines with "work" on
> the first line?
> 
Will align arguments with "work".

>> +	enum usb_role role = usb_role_switch_get_role(port->usb_role_sw);
>> +
>> +	dev_dbg(&port->dev, "%s calling notifier for role %d\n", __func__,
>> +		role);
>> +
>> +	atomic_notifier_call_chain(&port->usb_phy.notifier, role,
>> +				   &port->usb_phy);
> I'm curious: you use an atomic notifier call chain here but then you
> schedule work to call it. Typically you only need to schedule work if
> you get notified in atomic context and you need to process the event
> outside of the atomic context.
> 
> Since these are atomic notifiers, do we really need the work? Or the
> other way around: why not use regular notifiers if we're processing them
> from non-atomic contexts only anyway?
> 
notifier used by usb-phy are atomic notifiers and hence need to call
atomic_notifier_call_chain only in this context., regular notifiers
cannot be used.

>> +}
>> +
>>   static int tegra_xusb_role_sw_set(struct device *dev, enum usb_role role)
>>   {
>> +	struct tegra_xusb_port *port = dev_get_drvdata(dev);
>> +
>>   	dev_dbg(dev, "%s calling notifier for role is %d\n", __func__, role);
>>   
>> +	schedule_work(&port->usb_phy_work);
>> +
>> +	return 0;
>> +}
>> +
>> +static int tegra_xusb_set_peripheral(struct usb_otg *otg,
>> +					struct usb_gadget *gadget)
>> +{
>> +	struct tegra_xusb_port *port = container_of(otg->usb_phy,
>> +					struct tegra_xusb_port, usb_phy);
>> +
>> +	if (gadget != NULL)
>> +		schedule_work(&port->usb_phy_work);
>> +
>> +	return 0;
>> +}
>> +
>> +static int tegra_xusb_set_host(struct usb_otg *otg, struct usb_bus *host)
>> +{
>> +	struct tegra_xusb_port *port = container_of(otg->usb_phy,
>> +					struct tegra_xusb_port, usb_phy);
>> +
>> +	if (host != NULL)
>> +		schedule_work(&port->usb_phy_work);
>> +
>>   	return 0;
>>   }
>>   
>> +
>>   static int tegra_xusb_setup_usb_role_switch(struct tegra_xusb_port *port)
>>   {
>>   	int err = 0;
>> +	struct tegra_xusb_lane *lane = tegra_xusb_find_lane(port->padctl,
>> +							"usb2", port->index);
> You're not properly aligning the arguments here.
> 
> Thierry
> 
Will align here and other places accordingly.

-Nagarjuna
>>   	struct usb_role_switch_desc role_sx_desc = {
>>   					.set = tegra_xusb_role_sw_set,
>>   					.fwnode = dev_fwnode(&port->dev),
>> @@ -578,6 +625,30 @@ static int tegra_xusb_setup_usb_role_switch(struct tegra_xusb_port *port)
>>   		if (err != EPROBE_DEFER)
>>   			dev_err(&port->dev, "Failed to register USB role SW: %d",
>>   				err);
>> +		return err;
>> +	}
>> +
>> +	INIT_WORK(&port->usb_phy_work, tegra_xusb_usb_phy_work);
>> +
>> +	port->usb_phy.otg = devm_kzalloc(&port->dev,
>> +					 sizeof(struct usb_otg), GFP_KERNEL);
>> +	if (!port->usb_phy.otg)
>> +		return -ENOMEM;
>> +
>> +	/*
>> +	 * Assign phy dev to usb-phy dev. Host/device drivers can use phy
>> +	 * reference to retrieve usb-phy details.
>> +	 */
>> +	port->usb_phy.dev = &lane->pad->lanes[port->index]->dev;
>> +	port->usb_phy.dev->driver = port->padctl->dev->driver;
>> +	port->usb_phy.otg->usb_phy = &port->usb_phy;
>> +	port->usb_phy.otg->set_peripheral = tegra_xusb_set_peripheral;
>> +	port->usb_phy.otg->set_host = tegra_xusb_set_host;
>> +
>> +	err = usb_add_phy_dev(&port->usb_phy);
>> +	if (err < 0) {
>> +		dev_err(&port->dev, "Failed to add usbphy: %d\n", err);
>> +		return err;
>>   	}
>>   
>>   	/* populate connector entry */
>> diff --git a/drivers/phy/tegra/xusb.h b/drivers/phy/tegra/xusb.h
>> index 9f27899..2345657 100644
>> --- a/drivers/phy/tegra/xusb.h
>> +++ b/drivers/phy/tegra/xusb.h
>> @@ -268,6 +268,8 @@ struct tegra_xusb_port {
>>   	struct device dev;
>>   
>>   	struct usb_role_switch *usb_role_sw;
>> +	struct work_struct usb_phy_work;
>> +	struct usb_phy usb_phy;
>>   
>>   	const struct tegra_xusb_port_ops *ops;
>>   };
>> -- 
>> 2.7.4
