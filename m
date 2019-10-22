Return-Path: <SRS0=qxzQ=YP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11511CA9EA0
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Oct 2019 16:34:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D165220B7C
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Oct 2019 16:34:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="KyljymfC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389466AbfJVQdx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 22 Oct 2019 12:33:53 -0400
Received: from lelv0143.ext.ti.com ([198.47.23.248]:34362 "EHLO
        lelv0143.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389013AbfJVQdx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Oct 2019 12:33:53 -0400
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id x9MGXKEf062370;
        Tue, 22 Oct 2019 11:33:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1571762000;
        bh=sheWdBg/FARXedFGTyo5WLnAdkRnZwZx7yx0fQoXP6c=;
        h=Date:From:To:CC:Subject:References:In-Reply-To;
        b=KyljymfChE+xjo97ZBW7cePbfwRxTsJk1yiOqwq6MG/JuX96Ix9kHAjCaUXj9iJwW
         V/H/2BeNdTXRRLJ0UQL+Ps+3KTk1IrQU6RNHraWReYm3MrWHj6od4FZNsPW3qvdcp1
         BeLtiGBa/TVW8qf+iJinyJJCRgEuYgCtt6l1gMmU=
Received: from DLEE105.ent.ti.com (dlee105.ent.ti.com [157.170.170.35])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x9MGXJ46028457
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 22 Oct 2019 11:33:20 -0500
Received: from DLEE102.ent.ti.com (157.170.170.32) by DLEE105.ent.ti.com
 (157.170.170.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5; Tue, 22
 Oct 2019 11:33:09 -0500
Received: from lelv0327.itg.ti.com (10.180.67.183) by DLEE102.ent.ti.com
 (157.170.170.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5 via
 Frontend Transport; Tue, 22 Oct 2019 11:33:09 -0500
Received: from ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with SMTP id x9MGXJva038766;
        Tue, 22 Oct 2019 11:33:19 -0500
Date:   Tue, 22 Oct 2019 11:33:19 -0500
From:   Benoit Parrot <bparrot@ti.com>
To:     Tony Lindgren <tony@atomide.com>
CC:     Tero Kristo <t-kristo@ti.com>, Rob Herring <robh+dt@kernel.org>,
        <linux-omap@vger.kernel.org>, <linux-media@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [Patch 0/3] ARM: dts: dra7: add vpe nodes
Message-ID: <20191022163319.ceb5wkwabw3w3kou@ti.com>
References: <20191009175628.20570-1-bparrot@ti.com>
 <20191022162720.yile7i4qwxgbuuou@ti.com>
 <20191022163048.GY5610@atomide.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20191022163048.GY5610@atomide.com>
User-Agent: NeoMutt/20171215
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Tony Lindgren <tony@atomide.com> wrote on Tue [2019-Oct-22 09:30:48 -0700]:
> * Benoit Parrot <bparrot@ti.com> [191022 16:28]:
> > Tony,
> > 
> > Ping,
> > 
> > I already had comments from Rob but i would like your feedback before
> > sending a v2.
> 
> Looks good to me in general other than what Rob commented
> on. Did not spot any node naming issues here :)

Would I need to split off the clk*.c/.h as well here though?

Benoit

> 
> Regards,
> 
> Tony
