Return-Path: <SRS0=bMiL=T7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	T_DKIMWL_WL_HIGH,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF7CBC04AB6
	for <linux-kernel@archiver.kernel.org>; Fri, 31 May 2019 22:28:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8B79026F9D
	for <linux-kernel@archiver.kernel.org>; Fri, 31 May 2019 22:28:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1559341738;
	bh=Xp0v6FapU+e3UobKOyXcziq9VBayr/qwXAp0uerNeXI=;
	h=Date:From:To:cc:Subject:In-Reply-To:References:List-ID:From;
	b=z7L5eWkAZgKlWqtnqD2ocRlgofYq8n9ysMiKKoNXeW9aKWZw4DKjV8iNRR6oTGqWn
	 dpix78mdJHNSGtNIW2oyAH0L9jty4dqqpDkI8HRlGnb/W5gdvRaiJ2fIX7GI11xhWh
	 6wBXL9RLsffmVhvH8H5kLKxlmWERNEuyI8iVUQn8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726793AbfEaW25 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 May 2019 18:28:57 -0400
Received: from mail.kernel.org ([198.145.29.99]:45204 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726450AbfEaW25 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 May 2019 18:28:57 -0400
Received: from pobox.suse.cz (prg-ext-pat.suse.com [213.151.95.130])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AE6D726F26;
        Fri, 31 May 2019 22:28:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1559341736;
        bh=Xp0v6FapU+e3UobKOyXcziq9VBayr/qwXAp0uerNeXI=;
        h=Date:From:To:cc:Subject:In-Reply-To:References:From;
        b=Fe8R1NO+trfyNM6Ers4y1Z6KKifyzKT9NrCPcxVQ5UVu6FvYfIYpNU+BviI/vjyhP
         uzkdDi5+4SCD4LcQwh6BFHpsTTW2y1kpIFiPjezm+DXq8Tx3DldfqVJ7iGaXOLXqcX
         sb8CmQpQUNIlTjVvp/ivQXiSec9mfgC+2Y0gS3bA=
Date:   Sat, 1 Jun 2019 00:28:53 +0200 (CEST)
From:   Jiri Kosina <jikos@kernel.org>
To:     =?ISO-8859-2?Q?B=B3a=BFej_Szczygie=B3?= <spaz16@wp.pl>
cc:     igorkuo@gmail.com, peter.hutterer@who-t.net,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] HID: fix A4Tech horizontal scrolling
In-Reply-To: <20190512203313.18756-1-spaz16@wp.pl>
Message-ID: <nycvar.YFH.7.76.1906010028440.1962@cbobk.fhfr.pm>
References: <20190507050029.GA5197@jelly> <20190512203313.18756-1-spaz16@wp.pl>
User-Agent: Alpine 2.21 (LSU 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 12 May 2019, Błażej Szczygieł wrote:

> Since recent high resolution scrolling changes the A4Tech driver must
> check for the "REL_WHEEL_HI_RES" usage code.
> 
> Link: https://bugzilla.kernel.org/show_bug.cgi?id=203369
> Fixes: 2dc702c991e3774af9d7ce410eef410ca9e2357e ("HID: input: use the
> Resolution Multiplier for high-resolution scrolling")
> 
> Signed-off-by: Błażej Szczygieł <spaz16@wp.pl>

Applied, thanks.

-- 
Jiri Kosina
SUSE Labs

