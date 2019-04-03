Return-Path: <SRS0=7x1k=SF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F19BC4360F
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 11:34:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1D196206BA
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 11:34:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554291270;
	bh=6zSKsCND3bK8sNWuqO4COWEf8mr/T7mJmn3lK1UZ/x4=;
	h=Date:From:To:cc:Subject:In-Reply-To:References:List-ID:From;
	b=yBCVjW4tp6BnKQ9my9FECIOyU7gTJgix7bywIgvMychmxFsXRG7QMSd50TistMwoq
	 /sipbBVtUyvPaorXeaMcGFSqjkn/hXETs1s80I+lHnaYaXySjgys3iOghsFjGIncbD
	 xsxtcw/A47z27kNfd5C+iBnXG38ZT5zUtMFAdoG0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726531AbfDCLe3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Apr 2019 07:34:29 -0400
Received: from mail.kernel.org ([198.145.29.99]:45558 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725935AbfDCLe2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Apr 2019 07:34:28 -0400
Received: from pobox.suse.cz (prg-ext-pat.suse.com [213.151.95.130])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2EEEC206BA;
        Wed,  3 Apr 2019 11:34:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1554291268;
        bh=6zSKsCND3bK8sNWuqO4COWEf8mr/T7mJmn3lK1UZ/x4=;
        h=Date:From:To:cc:Subject:In-Reply-To:References:From;
        b=nXgCbrOqeFj9k4ewJD/r7Laq3+2FKluTrp05DjKJxdaNrAVqB+x3fRWm56iOJ04Fl
         luHynuRv+tTQwdra2RgDFnhcxt7X/Vx7IqsOwxaw2jokuOfDCe4iUfkcP739jlfxuk
         FpiJu9OXanEHcmNtPeu4TUxN5cbivmKU65of+WQE=
Date:   Wed, 3 Apr 2019 13:34:25 +0200 (CEST)
From:   Jiri Kosina <jikos@kernel.org>
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>
cc:     Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] HID: input: add mapping for Assistant key
In-Reply-To: <20190402165713.GA161074@dtor-ws>
Message-ID: <nycvar.YFH.7.76.1904031334170.9803@cbobk.fhfr.pm>
References: <20190402165713.GA161074@dtor-ws>
User-Agent: Alpine 2.21 (LSU 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2 Apr 2019, Dmitry Torokhov wrote:

> According to HUTRR89 usage 0x1cb from the consumer page was assigned to
> allow launching desktop-aware assistant application, so let's add the
> mapping.
> 
> Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>

Applied, thanks Dmitry.

-- 
Jiri Kosina
SUSE Labs

