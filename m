Return-Path: <SRS0=vU+5=XP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 165A7C49ED7
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Sep 2019 12:16:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D2FAC207FC
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Sep 2019 12:16:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="q6PGsaD+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2408925AbfITMQe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Sep 2019 08:16:34 -0400
Received: from fllv0015.ext.ti.com ([198.47.19.141]:41036 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2408911AbfITMQb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Sep 2019 08:16:31 -0400
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id x8KCGTHl095111;
        Fri, 20 Sep 2019 07:16:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1568981789;
        bh=k/T0dOY19jCkJs141qfwDG6vt1ucCgApv2cptBjTCa8=;
        h=Date:From:To:CC:Subject:References:In-Reply-To;
        b=q6PGsaD+rFo8v4ypuWObDV4CMly7bEpOyi+slrDPjmRBqfzh16IgHXvG7Uw6aZx/z
         rojWJt42eV3x5clEL20lt/UPOrm6z8xmS7Ut8RCaCZQdOpk3DV3iIWHz3DF5KqSoa6
         KJp89ewVgk6oO+ATiVcysem5tMoJ6C3zrc1HH6Tc=
Received: from DFLE114.ent.ti.com (dfle114.ent.ti.com [10.64.6.35])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x8KCGTFh115532
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 20 Sep 2019 07:16:29 -0500
Received: from DFLE112.ent.ti.com (10.64.6.33) by DFLE114.ent.ti.com
 (10.64.6.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5; Fri, 20
 Sep 2019 07:16:25 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DFLE112.ent.ti.com
 (10.64.6.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5 via
 Frontend Transport; Fri, 20 Sep 2019 07:16:25 -0500
Received: from ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with SMTP id x8KCGT9J012846;
        Fri, 20 Sep 2019 07:16:29 -0500
Date:   Fri, 20 Sep 2019 07:18:37 -0500
From:   Benoit Parrot <bparrot@ti.com>
To:     Hans Verkuil <hverkuil@xs4all.nl>
CC:     Prabhakar Lad <prabhakar.csengg@gmail.com>,
        <linux-media@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [Patch v2 10/13] media: am437x-vpfe: Remove print_fourcc helper
Message-ID: <20190920121837.bnhmgnknh72m4ujw@ti.com>
References: <20190919204125.15254-1-bparrot@ti.com>
 <20190919204125.15254-11-bparrot@ti.com>
 <455387f7-3211-c032-c6c0-a15100f123d1@xs4all.nl>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <455387f7-3211-c032-c6c0-a15100f123d1@xs4all.nl>
User-Agent: NeoMutt/20171215
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hans Verkuil <hverkuil@xs4all.nl> wrote on Fri [2019-Sep-20 10:21:17 +0200]:
> On 9/19/19 10:41 PM, Benoit Parrot wrote:
> > print_fourcc helper function was used for debug log to
> > convert a pixel format code into its readable form for display
> > purposes. But since it used a single static buffer to perform
> > the conversion this might lead to display format issue when more
> > than one instance was invoked simultaneously.
> > 
> > It turns out that print_fourcc can be safely replace by using
> > "%4pE" instead and passing the pointer to the fourcc code.
> 
> If this series is merged:
> 
> https://www.mail-archive.com/linux-media@vger.kernel.org/msg149985.html
> 
> then this patch needs to be rewritten. So I'll skip this patch for now.

Ok I'll monnitor the status of this patch and see if/when I'll rebase this
one.

Benoit

> 
> Regards,
> 
> 	Hans
> 
