Return-Path: <SRS0=OaAC=YQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BAF8ECA9EB7
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Oct 2019 16:05:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 91A7A205C9
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Oct 2019 16:05:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="m2vuIlwa"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406983AbfJWQF4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 23 Oct 2019 12:05:56 -0400
Received: from lelv0142.ext.ti.com ([198.47.23.249]:37650 "EHLO
        lelv0142.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390259AbfJWQFz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Oct 2019 12:05:55 -0400
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id x9NG5pJ7121566;
        Wed, 23 Oct 2019 11:05:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1571846751;
        bh=gdhsrVL8QxXfaU6C0gyNTMWtb/hfj2o3gXou565+b08=;
        h=Date:From:To:CC:Subject:References:In-Reply-To;
        b=m2vuIlwaX0XHZSnYMnMVQdo1dppXyxhupOjYnW2icxzosFaGa7fNq5aTcKPOwVtmD
         YTpuj+H41WFmIAJdgb0PMcMia3VdsNZsLvnvTV2FV3EYN5ZlhbeyoeeVxIVc0ildzY
         uIyYg9Gto5pcP3NMKSvd1QvheThfmIKTBIw8Pmwg=
Received: from DLEE109.ent.ti.com (dlee109.ent.ti.com [157.170.170.41])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x9NG5p34119291
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 23 Oct 2019 11:05:51 -0500
Received: from DLEE105.ent.ti.com (157.170.170.35) by DLEE109.ent.ti.com
 (157.170.170.41) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5; Wed, 23
 Oct 2019 11:05:41 -0500
Received: from fllv0039.itg.ti.com (10.64.41.19) by DLEE105.ent.ti.com
 (157.170.170.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5 via
 Frontend Transport; Wed, 23 Oct 2019 11:05:41 -0500
Received: from ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with SMTP id x9NG5nKN021875;
        Wed, 23 Oct 2019 11:05:50 -0500
Date:   Wed, 23 Oct 2019 11:05:43 -0500
From:   Benoit Parrot <bparrot@ti.com>
To:     Hans Verkuil <hverkuil@xs4all.nl>
CC:     Rob Herring <robh+dt@kernel.org>, <linux-media@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [Patch 00/19] media: ti-vpe: cal: maintenance
Message-ID: <20191023160543.a2cdy6rcfxgprqwu@ti.com>
References: <20191018153437.20614-1-bparrot@ti.com>
 <0f48c5a0-4c30-8c1c-928a-96af0321ed00@xs4all.nl>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <0f48c5a0-4c30-8c1c-928a-96af0321ed00@xs4all.nl>
User-Agent: NeoMutt/20171215
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hans Verkuil <hverkuil@xs4all.nl> wrote on Mon [2019-Oct-21 12:50:02 +0200]:
> Hi Benoit,
> 
> This series looks good to me. I had just one small comment on patch 7
> and a comment on patch 19.
> 
> Just post a v2 for just patch 7/19 and post a patch 20/19 for the requested
> MAINTAINERS change.
> 
> Once I have Rob's Acks I can merge this.

Ok, thanks.
I'll send a v2 probably later this week or early next.

Benoit

> 
> Regards,
> 
> 	Hans
> 
> On 10/18/19 5:34 PM, Benoit Parrot wrote:
