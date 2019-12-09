Return-Path: <SRS0=ag/Q=Z7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F07AC43603
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Dec 2019 04:43:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5985E206E0
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Dec 2019 04:43:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="i1pfDzlf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727044AbfLIEnq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 8 Dec 2019 23:43:46 -0500
Received: from hqnvemgate26.nvidia.com ([216.228.121.65]:17932 "EHLO
        hqnvemgate26.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726916AbfLIEnp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Dec 2019 23:43:45 -0500
Received: from hqpgpgate102.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate26.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5dedd0fa0000>; Sun, 08 Dec 2019 20:43:38 -0800
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate102.nvidia.com (PGP Universal service);
  Sun, 08 Dec 2019 20:43:44 -0800
X-PGP-Universal: processed;
        by hqpgpgate102.nvidia.com on Sun, 08 Dec 2019 20:43:44 -0800
Received: from DRHQMAIL107.nvidia.com (10.27.9.16) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Mon, 9 Dec
 2019 04:43:43 +0000
Received: from [10.24.193.46] (172.20.13.39) by DRHQMAIL107.nvidia.com
 (10.27.9.16) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Mon, 9 Dec 2019
 04:43:40 +0000
Subject: Re: [PATCH 01/18] dt-bindings: phy: tegra-xusb: Add usb-role-switch
To:     Thierry Reding <thierry.reding@gmail.com>
CC:     <balbi@kernel.org>, <gregkh@linuxfoundation.org>,
        <jonathanh@nvidia.com>, <mark.rutland@arm.com>,
        <robh+dt@kernel.org>, <kishon@ti.com>,
        <devicetree@vger.kernel.org>, <linux-tegra@vger.kernel.org>,
        <linux-usb@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <1575629421-7039-1-git-send-email-nkristam@nvidia.com>
 <1575629421-7039-2-git-send-email-nkristam@nvidia.com>
 <20191206144905.GC2085684@ulmo>
X-Nvconfidentiality: public
From:   Nagarjuna Kristam <nkristam@nvidia.com>
Message-ID: <59527c41-7388-b6ae-f49e-0f8eb1407063@nvidia.com>
Date:   Mon, 9 Dec 2019 10:15:29 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <20191206144905.GC2085684@ulmo>
X-Originating-IP: [172.20.13.39]
X-ClientProxiedBy: HQMAIL107.nvidia.com (172.20.187.13) To
 DRHQMAIL107.nvidia.com (10.27.9.16)
Content-Type: text/plain; charset="windows-1252"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1575866619; bh=/iLU56/spbM6Mb2IIsTD5NSr25ZYa5dT6Wh6Xh/lNbI=;
        h=X-PGP-Universal:Subject:To:CC:References:X-Nvconfidentiality:From:
         Message-ID:Date:User-Agent:MIME-Version:In-Reply-To:
         X-Originating-IP:X-ClientProxiedBy:Content-Type:Content-Language:
         Content-Transfer-Encoding;
        b=i1pfDzlfYBieWFLSrriODNoO9AUlqV+vsyiQNph2MULJPckU2bKiXECsrJXQ8t32G
         2c588hqrVymQohOTDbwPobe81+t79pB64noYTpFAgHbAkcoxtTXN1s60xDqOBEznFO
         D6lzqnwaKgisySj7DhWcxEkkqpr12dVtHmlPDi78Xk2iFJ2zmuvwDLD5HYQ6fDTbsL
         CCWb13NmQnf35VJHz+m0RoGZn27f1Ka3+AYd7C/wsmxpyGqUHNin0ozl/wWmrzgGqz
         Y5aoaZ1piCUnIx9qPCYmdrGz1Hrs2S0F8rmx2A41jAKxwMbkYunXAyo6SqTNZu8i9y
         H4LyZknQZR3Sw==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On 06-12-2019 20:19, Thierry Reding wrote:
> 
> On Fri, Dec 06, 2019 at 04:20:04PM +0530, Nagarjuna Kristam wrote:
>> Add usb-role-switch property for Tegra210 and Tegra186 platforms. This
>> entry is used by XUSB pad controller driver to register for role changes
>> for OTG/Peripheral capable USB 2 ports.
>>
>> Signed-off-by: Nagarjuna Kristam <nkristam@nvidia.com>
>> ---
>>  Documentation/devicetree/bindings/phy/nvidia,tegra124-xusb-padctl.txt | 4 ++++
>>  1 file changed, 4 insertions(+)
>>
>> diff --git a/Documentation/devicetree/bindings/phy/nvidia,tegra124-xusb-padctl.txt b/Documentation/devicetree/bindings/phy/nvidia,tegra124-xusb-padctl.txt
>> index 9fb682e..0f19ed6 100644
>> --- a/Documentation/devicetree/bindings/phy/nvidia,tegra124-xusb-padctl.txt
>> +++ b/Documentation/devicetree/bindings/phy/nvidia,tegra124-xusb-padctl.txt
>> @@ -179,6 +179,10 @@ Optional properties:
>>    is internal. In the absence of this property the port is considered to be
>>    external.
>>  - vbus-supply: phandle to a regulator supplying the VBUS voltage.
>> +- usb-role-switch: boolean property to indicate use of USB Role Switch.
> That first sentence here seems a bit useless and vague. It doesn't
> really convey anything other than the name already does. Perhaps
> something like:
> 
> 	Boolean property to indicate that the port support OTG. If
> 	present, the port supports switching between USB host and
> 	peripheral roles.
> 
Will update this accordingly.

>> +  This property is MUST for OTG,Peripheral capable USB 2 ports. Connector
> If this is mandatory, why not add it to the list of required properties?
> I guess since it's only mandatory for ports that support OTG, perhaps we
> could add a section "Required properties for OTG capable ports:" or
> something like that? Then you can also omit the second sentence in the
> description.
> 
Will add section "Required properties for OTG/Peripheral capable ports:" under ports
and add usb-role-switch there.

>> +  should be added as subnode, see connector.txt. vbus-gpio in connector is
> There's no file called "connector.txt". Are you referring to
> 
> 	Documentation/devicetree/bindings/connector/usb-connector.txt
> 
> ? Also, that file calls the property "vbus-gpios" and lists it as
> optional. What would happen if we don't specify it? Doesn't that just
> mean that we can't support role detection?
> 
After going through other bindings found usb/usb-conn-gpio.txt is the one that should
be referred. Will update accordingly. All details on gpios are documented clearly
in usb/usb-conn-gpio.txt.

>> +  Mandatory.
> "mandatory"
> 
> Thierry
> 
>>  
Will update.

Thanks,
Nagarjuna
>>  ULPI ports:
>>  -----------
>> -- 
>> 2.7.4
>>
