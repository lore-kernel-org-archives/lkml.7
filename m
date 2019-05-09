Return-Path: <SRS0=2Nly=TJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,T_DKIMWL_WL_HIGH,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB602C04AB1
	for <linux-kernel@archiver.kernel.org>; Thu,  9 May 2019 19:29:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9CA1E21479
	for <linux-kernel@archiver.kernel.org>; Thu,  9 May 2019 19:29:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1557430176;
	bh=BNyyC50Acgw97Vopdv8x3V69XEPOWL/oJFPZFr/wW8I=;
	h=Date:From:To:cc:Subject:In-Reply-To:References:List-ID:From;
	b=fkL8TukzKZt1qyU6O2Gq+YqILL9KOkvIGEjRLy8lVgVryrHrSq/slMTAwimGLTvUU
	 6broRDjBg5jhrwuKMQ1Ey4GN4QPdpQUVQWW/DUbWvpmcn2YavZ5lDm2CP/YhJzUyDO
	 8bW+gcMv8mzKDp9qAX1p+jQcQeBpWmrQ2FyShQS8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726995AbfEIT3f (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 May 2019 15:29:35 -0400
Received: from mail.kernel.org ([198.145.29.99]:39506 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726710AbfEIT3f (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 May 2019 15:29:35 -0400
Received: from pobox.suse.cz (prg-ext-pat.suse.com [213.151.95.130])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B977721479;
        Thu,  9 May 2019 19:29:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1557430174;
        bh=BNyyC50Acgw97Vopdv8x3V69XEPOWL/oJFPZFr/wW8I=;
        h=Date:From:To:cc:Subject:In-Reply-To:References:From;
        b=gLX9jNvfnVGU1+FWC/LfXWRXCICvqrpVhDwaQFcPa/1yrIQ3OthjN1hIXPB4AR9mb
         3F2fvv32c1uahNYTtv4dDRw3+l1Z6gq5tCJi/TGwzF6QV+wSflHNtk59kkjj+2uUXh
         i5quc1ANYcExAbqImKgPDJ/bvRqU0l1cShmbxwXE=
Date:   Thu, 9 May 2019 21:29:31 +0200 (CEST)
From:   Jiri Kosina <jikos@kernel.org>
To:     Kai-Heng Feng <kai.heng.feng@canonical.com>
cc:     benjamin.tissoires@redhat.com, linux-input@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] HID: i2c-hid: add iBall Aer3 to descriptor override
In-Reply-To: <20190422065704.27234-1-kai.heng.feng@canonical.com>
Message-ID: <nycvar.YFH.7.76.1905092129210.17054@cbobk.fhfr.pm>
References: <20190422065704.27234-1-kai.heng.feng@canonical.com>
User-Agent: Alpine 2.21 (LSU 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 22 Apr 2019, Kai-Heng Feng wrote:

> This device uses the SIPODEV SP1064 touchpad, which does not
> supply descriptors, so it has to be added to the override
> list.
> 
> BugLink: https://bugs.launchpad.net/bugs/1825718
> Signed-off-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
> ---
>  drivers/hid/i2c-hid/i2c-hid-dmi-quirks.c | 8 ++++++++
>  1 file changed, 8 insertions(+)

Applied to for-5.2/fixes. Thanks,

-- 
Jiri Kosina
SUSE Labs

