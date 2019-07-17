Return-Path: <SRS0=Ncac=VO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ABE63C76186
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jul 2019 11:30:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 82DD2217F4
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jul 2019 11:30:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1563363040;
	bh=kYrTFywVNEOcsqT9h3RDsiGtTWLaNmgHCsJqpgxej5M=;
	h=Date:From:To:cc:Subject:In-Reply-To:References:List-ID:From;
	b=mfS+7A0XpFZTm0DQbrndixWA5hXzgcqTaV8lgCBnZRH48Pg+vxPdBcvb2uPehQ3Ep
	 SXh2m13f9+ielt0NVrenYjY6f7ImX+dBX/BNUS9yQNNak23wtVgprccOFQbzRcqX8D
	 WnkRqGZ9zVQwftibQhJyaNt5I+FQbgrudQl4cE20=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726805AbfGQLaj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Jul 2019 07:30:39 -0400
Received: from mail.kernel.org ([198.145.29.99]:33856 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725873AbfGQLai (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Jul 2019 07:30:38 -0400
Received: from pobox.suse.cz (prg-ext-pat.suse.com [213.151.95.130])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7E5E520880;
        Wed, 17 Jul 2019 11:30:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1563363037;
        bh=kYrTFywVNEOcsqT9h3RDsiGtTWLaNmgHCsJqpgxej5M=;
        h=Date:From:To:cc:Subject:In-Reply-To:References:From;
        b=CacGiyKcDt0dGbSHJjdPxPxPksfAy0UogtH9e3Z6DTpc26ccLB82v38aUtOCON1Kd
         WlEyKKx9239zGlHPH/QS+0sC9LOWMgnjEQT3B/hYlyz5ncsJUsCIruQt/Pl+Ln7hz2
         aj+8cOOvTL5Z0uwVfj2BqFYsMgDNITvsx/1kuNiY=
Date:   Wed, 17 Jul 2019 13:30:27 +0200 (CEST)
From:   Jiri Kosina <jikos@kernel.org>
To:     =?ISO-8859-15?Q?Filipe_La=EDns?= <lains@archlinux.org>
cc:     nlopezcasad@logitech.com,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] hid-logitech-dj: rename "gaming" receiver to
 "lightspeed"
In-Reply-To: <20190716073621.4290-1-lains@archlinux.org>
Message-ID: <nycvar.YFH.7.76.1907171330190.5899@cbobk.fhfr.pm>
References: <20190716073621.4290-1-lains@archlinux.org>
User-Agent: Alpine 2.21 (LSU 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Applied, thans.

-- 
Jiri Kosina
SUSE Labs

