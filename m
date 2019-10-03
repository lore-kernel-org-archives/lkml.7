Return-Path: <SRS0=6dNS=X4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 473CFC10F14
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Oct 2019 21:09:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1358721D81
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Oct 2019 21:09:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1570136988;
	bh=ebtTzy1JZkgeZmqVXSOzAKS+6uZXcSAohkg+1FReh1s=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=k1aYAC8beaQwpxfNr91i+6QYf8DGtGySA8JjHmELANSVcAvZ3k1TUJs8KtMvgm10p
	 lmQwPrcgshvRG2xhx9X1NNrnIbZiYzL75P7oBGUVAng0ctmsPqeQHvoway6nqwm+CV
	 z+P4gplwpptNjRnwiy+BAnVbpuxoOVmdHvcvyVAo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731328AbfJCVJr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Oct 2019 17:09:47 -0400
Received: from mail.kernel.org ([198.145.29.99]:49296 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727789AbfJCVJq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Oct 2019 17:09:46 -0400
Received: from willie-the-truck (236.31.169.217.in-addr.arpa [217.169.31.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B331D20862;
        Thu,  3 Oct 2019 21:09:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1570136986;
        bh=ebtTzy1JZkgeZmqVXSOzAKS+6uZXcSAohkg+1FReh1s=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=oabMIHhnfum50A1BjidbQuyquD+uFCBlGFB0Bab6JpNTL7F8MW0UTaES5FXOISuYm
         MjpdvPh2wknpvXwoPwDkI9Kvn7cBo6gvaE7SeXGmgATkUqgyZVfWSYbZWCTcLS4iY1
         VqX3mxaeafXyjgU6Pzo7IaMLRrP2ZyAcV25Qslxc=
Date:   Thu, 3 Oct 2019 22:09:41 +0100
From:   Will Deacon <will@kernel.org>
To:     Douglas Anderson <dianders@chromium.org>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Jason Wessel <jason.wessel@windriver.com>,
        Daniel Thompson <daniel.thompson@linaro.org>,
        kgdb-bugreport@lists.sourceforge.net,
        Christophe Leroy <christophe.leroy@c-s.fr>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 3/4] kdb: Fix "btc <cpu>" crash if the CPU didn't
 round up
Message-ID: <20191003210941.ulbnglhhx7nevsfm@willie-the-truck>
References: <20190925200220.157670-1-dianders@chromium.org>
 <20190925125811.v3.3.Id33c06cbd1516b49820faccd80da01c7c4bf15c7@changeid>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190925125811.v3.3.Id33c06cbd1516b49820faccd80da01c7c4bf15c7@changeid>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 25, 2019 at 01:02:19PM -0700, Douglas Anderson wrote:
> I noticed that when I did "btc <cpu>" and the CPU I passed in hadn't
> rounded up that I'd crash.  I was going to copy the same fix from
> commit 162bc7f5afd7 ("kdb: Don't back trace on a cpu that didn't round
> up") into the "not all the CPUs" case, but decided it'd be better to
> clean things up a little bit.
> 
> This consolidates the two code paths.  It is _slightly_ wasteful in in

nit: in in

Will
