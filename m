Return-Path: <SRS0=BZT9=SS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7901DC10F13
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 16:38:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 416D420821
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 16:38:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=akkea.ca header.i=@akkea.ca header.b="a9/NJegz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729646AbfDPQiX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Apr 2019 12:38:23 -0400
Received: from node.akkea.ca ([192.155.83.177]:36648 "EHLO node.akkea.ca"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726816AbfDPQiW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Apr 2019 12:38:22 -0400
Received: by node.akkea.ca (Postfix, from userid 33)
        id 571D24E204B; Tue, 16 Apr 2019 16:38:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=akkea.ca; s=mail;
        t=1555432702; bh=XLQ7M8uOdC7iqAlhAXhyGUphqNE1jJZ/aX754kOBwF0=;
        h=To:Subject:Date:From:Cc:In-Reply-To:References;
        b=a9/NJegzGPG5wUfgurfHTKGwhzgLn+5zffbBZGZKG8pKsVHzBqiZqQye2mcaz8K0C
         hewibBJ/eC2VM6Nhehyexdn3IHk2+Wgz6sTzyfgsV6QLyQHoMAa8VeeTnuSGvBTj1F
         KnkNYNx1bwtWFP4vmC+u6vtC35AppXz8ehf9IE2I=
To:     Marco Felsch <m.felsch@pengutronix.de>
Subject: Re: [PATCH v4 0/2] Add support for the Purism Librem5 devkit
X-PHP-Originating-Script: 1000:rcube.php
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Tue, 16 Apr 2019 09:38:22 -0700
From:   Angus Ainslie <angus@akkea.ca>
Cc:     Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        linux-kernel@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        NXP Linux Team <linux-imx@nxp.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        linux-arm-kernel@lists.infradead.org
In-Reply-To: <20190416075834.6wurd6nq4ow5woyn@pengutronix.de>
References: <20190415235343.16565-1-angus@akkea.ca>
 <20190416075834.6wurd6nq4ow5woyn@pengutronix.de>
Message-ID: <665773559cd9449a27fc9bc40cf73792@www.akkea.ca>
X-Sender: angus@akkea.ca
User-Agent: Roundcube Webmail/1.1.3
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2019-04-16 00:58, Marco Felsch wrote:
> Hi Agnus,
> 
> On 19-04-15 16:53, Angus Ainslie (Purism) wrote:
>> The Librem5 devkit is based on the imx8mq from NXP. This is a default
>> devicetree to boot the board to a command prompt.
> 
> You should also provide a patch which adds the devicetree to the yaml
> file, see: Documentation/devicetree/bindings/arm/fsl.yaml.
> 

Sure, what is that yaml file for ?

Angus

> Thanks,
>   Marco
> 
>> 
>> Changes since v3:
>> 
>> Freshly sorted and pressed nodes.
>> Change the backlight to an interpolated scale.
>> Dropped i2c2.
>> Dropped devkit version number to match debian MR.
>> 
>> Changes since v2:
>> 
>> Fixed incorrect phy-supply for the fsl-fec.
>> Dropped unused regulator property.
>> Fixup Makefile for linux-next.
>> 
>> Changes since v1:
>> 
>> Dropped config file.
>> Updated the board compatible label.
>> Changed node names to follow naming conventions.
>> Added a more complete regulator hierachy.
>> Removed unused nodes.
>> Removed unknown devices.
>> Fixed comment style.
>> Dropped undocumented properties.
>> 
>> Angus Ainslie (Purism) (2):
>>   arm64: dts: fsl: librem5: Add a device tree for the Librem5 devkit
>>   dt-bindings: Add an entry for Purism SPC
>> 
>>  .../devicetree/bindings/vendor-prefixes.txt   |   1 +
>>  arch/arm64/boot/dts/freescale/Makefile        |   1 +
>>  .../dts/freescale/imx8mq-librem5-devkit.dts   | 822 
>> ++++++++++++++++++
>>  3 files changed, 824 insertions(+)
>>  create mode 100644 
>> arch/arm64/boot/dts/freescale/imx8mq-librem5-devkit.dts
>> 
>> --
>> 2.17.1
>> 
>> 
>> 

