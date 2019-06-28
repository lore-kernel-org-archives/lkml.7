Return-Path: <SRS0=E/6H=U3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A261C4321A
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Jun 2019 20:38:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CF9B32086D
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Jun 2019 20:38:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="MYQYl81U"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727213AbfF1UiE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Jun 2019 16:38:04 -0400
Received: from fllv0016.ext.ti.com ([198.47.19.142]:40438 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727173AbfF1UiE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jun 2019 16:38:04 -0400
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id x5SKbt9Q023305;
        Fri, 28 Jun 2019 15:37:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1561754275;
        bh=qmjPdpLPSWAbNfzvl0aaOl50HSO4HcYPbHirzrfr7ZI=;
        h=Date:From:To:CC:Subject:References:In-Reply-To;
        b=MYQYl81UM5yoC89mnR/inx37O4v6oLP7Rm7cPKT9hnUsBYrwbOMIRnadob18bJY2v
         VSwPajYeoR5NXWElHRiTYQ0b5/FyR3W+218zbz/XlpZBfuduO4yEvO1PLoFRGTjFDi
         d52Cx2Ys61aX9LUA1z/BAJ0wZP6IyR6N09c8LQy4=
Received: from DFLE105.ent.ti.com (dfle105.ent.ti.com [10.64.6.26])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x5SKbtRB020988
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 28 Jun 2019 15:37:55 -0500
Received: from DFLE110.ent.ti.com (10.64.6.31) by DFLE105.ent.ti.com
 (10.64.6.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5; Fri, 28
 Jun 2019 15:37:55 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DFLE110.ent.ti.com
 (10.64.6.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5 via
 Frontend Transport; Fri, 28 Jun 2019 15:37:55 -0500
Received: from localhost (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id x5SKbtYP000389;
        Fri, 28 Jun 2019 15:37:55 -0500
Date:   Fri, 28 Jun 2019 15:37:52 -0500
From:   Nishanth Menon <nm@ti.com>
To:     Keerthy <j-keerthy@ti.com>
CC:     <t-kristo@ti.com>, <will.deacon@arm.com>,
        <catalin.marinas@arm.com>, <shawnguo@kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <lokeshvutla@ti.com>
Subject: Re: [PATCH v2] arm64: Kconfig.platforms: Enable GPIO_DAVINCI for
 ARCH_K3
Message-ID: <20190628203752.rdb6vvc42qd5ofgd@kahuna>
References: <20190627110920.15099-1-j-keerthy@ti.com>
 <20190627143208.eeca4xyygml7s4n3@kahuna>
 <39f5e726-8542-b650-3bdb-7542e8fab8ac@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <39f5e726-8542-b650-3bdb-7542e8fab8ac@ti.com>
User-Agent: NeoMutt/20171215
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09:08-20190628, Keerthy wrote:
[..]
> > > +	select GPIO_SYSFS
> > > +	select GPIO_DAVINCI
> > 
> > 
> > Could you help explain the logic of doing this? commit message is
> > basically the diff in English. To me, this does NOT make sense.
> > 
> > I understand GPIO_DAVINCI is the driver compatible, but we cant do this for
> > every single SoC driver that is NOT absolutely mandatory for basic
> > functionality.
> 
> In case of ARM64 could you help me find the right place to enable
> such SoC specific configs?

Is'nt that what defconfig is supposed to be all about?

arch/arm64/configs/defconfig

> 
> > 
> > Also keep in mind the impact to arm64/configs/defconfig -> every single
> > SoC in the arm64 world will be now rebuild with GPIO_SYSFS.. why force
> > that?
> 
> This was the practice in arm32 soc specific configs like
> omap2plus_defconfig. GPIO_SYSFS was he only way to validate. Now i totally
> understand your concern about every single SoC rebuilding but now where do
> we need to enable the bare minimal GPIO_DAVINCI config?

Well, SYSFS, I cannot agree testing as the rationale in
Kconfig.platform. And, looking at [1], I see majority being mandatory
components for the SoC bootup. However, most of the "optional" drivers
go into arm64 as defconfig (preferably as a module?) and if you find a
rationale for recommending DEBUG_GPIO, you could propose that to the
community as well.

Now, Thinking about this, I'd even challenge the current list of configs as
being "select". I'd rather do an "imply"[2] - yes, you need this for the
default dtb to boot, however a carefully carved dtb could boot with
lesser driver set to get a smaller (and less functional) kernel.

> 
> v1 i received feedback from Tero to enable in Kconfig.platforms. Hence i
> shifted to this approach.

I noticed that you were posting a v2, for future reference, please use
diffstat section to point to lore/patchworks link to point at v1 (I
did notice you mentioned you had an update, thanks - link will help
catch up on older discussions). This helps a later revision reviewer
like me to get context.

Tero, would you be able to help with a better rationale as to where the
boundaries are to be in your mind, rather than risk every single
peripheral driver getting into ARCH_K3?

As of right now, I'd rather we do not explode the current list out of
bounds. NAK unless we can find a better rationale.


[1] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/arch/arm64/Kconfig.platforms
[2] https://www.kernel.org/doc/Documentation/kbuild/kconfig-language.txt

-- 
Regards,
Nishanth Menon
