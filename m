Return-Path: <SRS0=OaAC=YQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C720C47E49
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Oct 2019 05:42:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 00C762173B
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Oct 2019 05:42:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="p58WL8S1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731833AbfJWFm1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 23 Oct 2019 01:42:27 -0400
Received: from lelv0142.ext.ti.com ([198.47.23.249]:45236 "EHLO
        lelv0142.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725789AbfJWFm0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Oct 2019 01:42:26 -0400
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id x9N5gC3H022595;
        Wed, 23 Oct 2019 00:42:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1571809332;
        bh=loVH+PYRxm3OpLF9LdBwXFuK6Y4m05IaOaKEfYsJyAw=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=p58WL8S1GmDISYuKnhXNvZOeoUrdYkV463yym9NPfhRAo+iXa+g8Yy3fcFkrbFq25
         yYJ1bfHdTyIVAT+qswO8C0xpw5FLvVQpuJgSjvVlzOopFBeuQic9qIgtN37tpmlq4o
         7DZ7fqtNrh9Cic2tWE6XjqRuRNO/gF7vMzJfcSK0=
Received: from DLEE113.ent.ti.com (dlee113.ent.ti.com [157.170.170.24])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x9N5gBAG020654
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 23 Oct 2019 00:42:12 -0500
Received: from DLEE111.ent.ti.com (157.170.170.22) by DLEE113.ent.ti.com
 (157.170.170.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5; Wed, 23
 Oct 2019 00:42:01 -0500
Received: from lelv0327.itg.ti.com (10.180.67.183) by DLEE111.ent.ti.com
 (157.170.170.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5 via
 Frontend Transport; Wed, 23 Oct 2019 00:42:01 -0500
Received: from [172.24.190.233] (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id x9N5ecZS004724;
        Wed, 23 Oct 2019 00:40:39 -0500
Subject: Re: [PATCH v2 04/11] dt-bindings: phy-mtk-tphy: add a new reference
 clock
To:     Rob Herring <robh@kernel.org>,
        Chunfeng Yun <chunfeng.yun@mediatek.com>
CC:     Mark Rutland <mark.rutland@arm.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>
References: <1567149298-29366-1-git-send-email-chunfeng.yun@mediatek.com>
 <1567149298-29366-4-git-send-email-chunfeng.yun@mediatek.com>
 <20190917202805.GA13405@bogus>
From:   Kishon Vijay Abraham I <kishon@ti.com>
Message-ID: <32bc288e-dbbb-8930-4750-826e9e17d58c@ti.com>
Date:   Wed, 23 Oct 2019 11:10:09 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20190917202805.GA13405@bogus>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Rob,

On 18/09/19 1:58 AM, Rob Herring wrote:
> On Fri, 30 Aug 2019 15:14:51 +0800, Chunfeng Yun wrote:
>> Usually the digital and analog phys use the same reference clock,
>> but on some platforms, they are separated, so add another optional
>> clock to support it.
>> In order to keep the clock names consistent with PHY IP's, use
>> the da_ref for analog phy and ref clock for digital phy.
>>
>> Signed-off-by: Chunfeng Yun <chunfeng.yun@mediatek.com>
>> ---
>> v2: fix typo of analog and needed
>> ---
>>  Documentation/devicetree/bindings/phy/phy-mtk-tphy.txt | 7 +++++--
>>  1 file changed, 5 insertions(+), 2 deletions(-)
>>
> 
> Acked-by: Rob Herring <robh@kernel.org>

I see you've acked a couple of patches in the series. However the other
dt-binding patch neither has an Ack or NAK. Is there a specific reason or can I
merge the series?

Thanks
Kishon
