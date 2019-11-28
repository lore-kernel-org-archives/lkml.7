Return-Path: <SRS0=QHyQ=ZU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1D22C432C0
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Nov 2019 22:59:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 911AF20880
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Nov 2019 22:59:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=web.de header.i=@web.de header.b="ECzHCdVK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726656AbfK1W7y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Nov 2019 17:59:54 -0500
Received: from mout.web.de ([212.227.15.3]:42843 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726582AbfK1W7y (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Nov 2019 17:59:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1574981980;
        bh=EvEfm6y/RB5YckvRo/5+L6OhoAw+x433Z/iu5wl68Pc=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=ECzHCdVK8KEUyJtqZfSrrZ5rMAtWX3SXgA7dsUO7RQnH+R2aRMLB+bBZpeGDyeK99
         4ZVrDNHAQIW5cWGZRGvXZ//9OeKLiD2G1naPwu4sXD1PnxoEvZsjvYhFzSBKZH6+x8
         VImnQiStQr+/dzVtdkkAz58VQAZRug68v1MOy/OE=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.43.108] ([89.204.139.119]) by smtp.web.de (mrweb002
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0LZvrx-1hwDzy32eD-00ll8L; Thu, 28
 Nov 2019 23:59:39 +0100
Subject: Re: [PATCH v2] arm64: dts: rockchip: split rk3399-rockpro64, for v2
 and v2.1 boards
To:     Heiko Stuebner <heiko@sntech.de>
Cc:     Katsuhiro Suzuki <katsuhiro@katsuster.net>,
        Vasily Khoruzhick <anarsoul@gmail.com>,
        linux-rockchip@lists.infradead.org,
        arm-linux <linux-arm-kernel@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Hugh Cole-Baker <sigmaris@gmail.com>
References: <3fa2e3df-221b-99a8-796a-2e21f75cf706@web.de>
 <9133677.cKcSbgiQdr@phil>
From:   Soeren Moch <smoch@web.de>
Message-ID: <f6dc3daf-7cfb-0ac2-99ee-1c691eaf2ef0@web.de>
Date:   Thu, 28 Nov 2019 23:59:37 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <9133677.cKcSbgiQdr@phil>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Provags-ID: V03:K1:GTMg10fwIdQgUypiLStUkuDQaNnuemDGISy4kPeso8Aml2Yiy3J
 XtmDMK1Ck9OCIgB4gsvXpwluyfHEvVL6odI13iVUGcJkp8gIKMkbhpmj22h0kwTZ0gpG1iQ
 hwb/wytSRQ4Fv3jJZaoAPEiNtYb7IWNr/qszbQWVTWnWM+BcdH7Wf2IQ39U68XlEdl1lWJg
 JrMLLTWCDs1r/aF2CwWNA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:tNqU8rJXfoE=:L/TF0Z0VappKZaTu5kUmcC
 Y3w/seh85+uHhb3ZXodgr/DvZRVReMe09Nyb+V+oyWBETEvRbbL++HbPRFpk4M4XMUdjf76t+
 pz1C0ILVqt/+8MFw+sP/Us5zWWdxDhPHQJA00ax2196FxN/9PYQwaeCBu6oA44P3f2WMxMQ1p
 myRG9gtl3lGk4QLJcH2avmBUJAWuTpcOQcRbz3sbgN9acOTXVoxC04USTcUUmFz3d4ufnJIOi
 WBklHLLxWVP0o8agZ+MYDxcX+thhsFnvzm+w7ofrdly7xfv/Jbi4Mf86fdStI4zS0x184dYC3
 y+JwBVbNewVz/+iXUhc1bHdocbk6vdP78ZHLl5Oevgd/t/+ATFhV96y0i26KnXRk/IGb0s7+X
 qAMUYXcA9XdpG1W7YWybCRpgzklqAXW1l6a8GqDqaPzIoow4mZN9SNNXU1dUdpS4JoPDh0Go0
 HLuVQPgr3mVe02rFsa2NAyAskoaeQO/XB10r8DqOwejooToermq3y0t13+f642w8L4iJO/oqw
 maqIFEsGkpGFDgcZlYiC6/XRqFlSLhJ+jylXXsCxKOiyBU9Bzz32OYXejcGRfGQJxo5V+RF51
 2VSMynG3lG0f7iaI2FAogltuzCLzzGGCOXgQSX6DMhTDeSUZ5wuHPkQfCdsjBsrKp8RmEM2D9
 ebM0azGWsik6XZh1ecCcDCg+G/DcI//khthFQCPCaE0RF3CBNfB/zFwMJYxC+nRkTAbXyzKBE
 1cTWCWfH9usk5q3EW54j/GVBXhIM0q9ZmggCtTvINVDyVG80Z60x6Py4ZwcPYPcEcHPM2wC/3
 JtY8UtwMgHW5ObswoItIU4+IOEnk5lWpb8nAZdksuSoochBX4fT/bHHGclCGZv9xOVlesslVV
 35DaV5YDxVxyBYczKnf2wrnXNbyD2FyHDUJvRYA6lqesBPipVlsFvxbvxdlaK+Kx0jWXBl0/I
 OPRImOfES5z49bbvgkCBixNUvVM3muvShFLz6c3k6nbknNTKZzTLEHUCvFM5f2E38z3WRmedm
 PYQyDHtQL0M8+gbDS0YrFMZjDrrsUakq9vfchxmRNn8ol0PooEArQ0ahHc1dzrgZfN5uTQQXC
 hXI7+kLzgGOJCaPZw46Mitg+fP+Z7jgPo1YIl5UPksBeMiZz/xkwE5Sq07iQDM6WnU+62ly4f
 sarMThs25UovzQSHKseDrDgV3OHbButJ1PBfF5GfiP9KVGSkbKZM+ygvLU+NvCD2WJOuPNUNK
 Gn6ERpHWFPHsd+wlg855oiXLLJu5BCKDhIs0coA==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 28.11.19 22:53, Heiko Stuebner wrote:
> Am Donnerstag, 28. November 2019, 20:55:54 CET schrieb Soeren Moch:
>>> On Thu, Nov 28, 2019 at 6:02 AM Katsuhiro Suzuki
>>> <katsuhiro@katsuster.net> wrote:
>>>> This patch splits rk3399-rockpro64 dts file to 2 files for v2 and
>>>> v2.1 boards.
>>>>
>>>> Both v2 and v2.1 boards can use almost same settings but we find a
>>>> difference in I2C address of audio CODEC ES8136.
>>>>
>>>> Reported-by: Vasily Khoruzhick <anarsoul@gmail.com>
>>>> Signed-off-by: Katsuhiro Suzuki <katsuhiro@katsuster.net>
>>>>
>>>> ---
> [...]
>
>>>> diff --git a/arch/arm64/boot/dts/rockchip/rk3399-rockpro64.dtsi b/arch/arm64/boot/dts/rockchip/rk3399-rockpro64.dtsi
>>>> new file mode 100644
>>>> index 000000000000..183eda4ffb9c
>>>> --- /dev/null
>> If we add this as new file, should we sort handles and properties
>> alphabetically, where it is not done yet?
> I'm torn here ... on one side, doing missing sorting might be nice
> on the other hand, there is the moving without functional changes
> paradigm, which is generally nice to adhere to.
Agreed. Since we don't move a file, but most of it's content, it was not
clear to me what's more important.
>
> But I guess sorting would generally be ok.
>
>> I'm not sure about all the exceptions that usually apply for rockchip
>> devicetrees, status property at the end, also the pinctrl node?
> In general I don't "enforce" the sorting, so don't reject patches but instead
> just do sorting myself if necessary ;-).
>
> The general rule-of-thumb for nodes we came up with during the rk3288-veyron
> era is something like:
>
> compatible
> reg
> interrupts
> [alphabetical properties]
> status
>
> as this makes it somewhat easier to parse the core properties (compatible,
> reg, ints, status] when scrolling through a devicetree :-) .
Thanks for your explanation, perfectly makes sense.
>
> Pinctrl position is at the discretion of the dt author :-D .
> Position at the end has just the advantage that a long pin-group list does
> not get in the way so much.
>
>> What about unused references, e.g. "fan"?
> Don't change too much when moving stuff around :-)
Yes, good compromise to do some sorting, but no other changes.

Thanks,
Soeren
