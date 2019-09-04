Return-Path: <SRS0=tMFY=W7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6911BC3A5A7
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Sep 2019 12:33:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3C0C92339E
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Sep 2019 12:33:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1567600387;
	bh=iuK4+h4YFFTVKBy7pPD8lTU3pbW/2NrPyHqI2eq7oMw=;
	h=Date:From:To:cc:Subject:In-Reply-To:References:List-ID:From;
	b=fijjPBoMaYXLjk2njYcSj6Up/4HSCqc7mwBBZNTMs/CWN2tM6zDsu/nrsrjqS5KOs
	 0RPa6u6c65DVjj+r5kTEefX8P+iMApzEnroi2om9OYT5ZYdTnfkiKelILMbRL8OqJi
	 Z3WQCYl1VysLC+9knvv1yIeDZLs9joCcBh3USCj8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730005AbfIDMdG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Sep 2019 08:33:06 -0400
Received: from mail.kernel.org ([198.145.29.99]:53884 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726589AbfIDMdG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Sep 2019 08:33:06 -0400
Received: from pobox.suse.cz (prg-ext-pat.suse.com [213.151.95.130])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0F33721670;
        Wed,  4 Sep 2019 12:33:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1567600385;
        bh=iuK4+h4YFFTVKBy7pPD8lTU3pbW/2NrPyHqI2eq7oMw=;
        h=Date:From:To:cc:Subject:In-Reply-To:References:From;
        b=F0Az6iIBAvsG7fsXxY/+AWi2NV2/m2GV8hoAIXjALmOOhlgKr3IMmRG/798rn7MC1
         QmfDfBFx2xHXK6IyGww1Lh5rbkb1IIK3ZlKABmktrMPS3D+v1p7Kkf9m0xtuZjmGov
         xwwkP4calS2qlzvRpmN06gFLWxUNhgONLwyndb+Q=
Date:   Wed, 4 Sep 2019 14:32:39 +0200 (CEST)
From:   Jiri Kosina <jikos@kernel.org>
To:     hn.chen@weidahitech.com
cc:     linux-input@vger.kernel.org, benjamin.tissoires@redhat.com,
        linux-kernel@vger.kernel.org, dmitry.torokhov@gmail.com
Subject: Re: [PATCH] HID: modify quirks of i2c-hid driver for weida's
 devices
In-Reply-To: <1567151910-3819-1-git-send-email-hn.chen@weidahitech.com>
Message-ID: <nycvar.YFH.7.76.1909041432310.31470@cbobk.fhfr.pm>
References: <1567151910-3819-1-git-send-email-hn.chen@weidahitech.com>
User-Agent: Alpine 2.21 (LSU 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 30 Aug 2019, hn.chen@weidahitech.com wrote:

> From: HungNien Chen <hn.chen@weidahitech.com>
> 
> This 'SET_PWR_WAKEUP_DEV' quirk only works for weida's devices with pid
> 0xC300 & 0xC301. Some weida's devices with other pids also need this quirk
> now. Use 'HID_ANY_ID' instead of 0xC300 to make all of weida's devices can be
> fixed on the power on issue. This modification should be safe since devices
> without power on issue will send the power on command only once.

Applied, thanks.

-- 
Jiri Kosina
SUSE Labs

