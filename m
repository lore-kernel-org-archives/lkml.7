Return-Path: <SRS0=hRvo=UZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61CEDC48BD3
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Jun 2019 12:02:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3044C20B1F
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Jun 2019 12:02:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1561550521;
	bh=vheSS1kXqdxt3pqny7qpx7vt14bV6C/mIPWbVOThWds=;
	h=Date:From:To:cc:Subject:In-Reply-To:References:List-ID:From;
	b=MVES+vr6Z4iErLHQ0v+RtjcoD68QjIzFFryjMnt0NBvbI+DECMhxXMvYaThub6r+y
	 /DK9CM5o3troGvdlXJSbeI7h8FPvuLhOSMTLKZE55eEkHc5zPGx/aUxUN5gLGZbxzv
	 IsPTrcB1oliZnlklCZAQtoLGHJE4Rd5MzqpuxiEw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727377AbfFZMB7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Jun 2019 08:01:59 -0400
Received: from mail.kernel.org ([198.145.29.99]:44332 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726484AbfFZMB5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jun 2019 08:01:57 -0400
Received: from pobox.suse.cz (prg-ext-pat.suse.com [213.151.95.130])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0A6B12080C;
        Wed, 26 Jun 2019 12:01:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1561550517;
        bh=vheSS1kXqdxt3pqny7qpx7vt14bV6C/mIPWbVOThWds=;
        h=Date:From:To:cc:Subject:In-Reply-To:References:From;
        b=eg+CHsUDJvn40wihQYPF4GUf7BX1MDnCycC0zij6YDbqmj4Nt7n/Y+BTIb3POenEn
         EbwOiwtjPy/iUKmZvEwBE69Bn7V37dDXA/ySYQChW+1eW6Be7aqYm2pEAdYYOMdAyS
         7d4QsU+3g3LdbmFyGPUj87bYQwIjbWLbBBmz12ZY=
Date:   Wed, 26 Jun 2019 14:01:54 +0200 (CEST)
From:   Jiri Kosina <jikos@kernel.org>
To:     Kyle Godbey <me@kyle.ee>
cc:     Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] HID: uclogic: Add support for Huion HS64 tablet
In-Reply-To: <20190615231506.17443-1-me@kyle.ee>
Message-ID: <nycvar.YFH.7.76.1906261401440.27227@cbobk.fhfr.pm>
References: <20190615231506.17443-1-me@kyle.ee>
User-Agent: Alpine 2.21 (LSU 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 15 Jun 2019, Kyle Godbey wrote:

> Add support for Huion HS64 drawing tablet to hid-uclogic

Applied, thanks.

-- 
Jiri Kosina
SUSE Labs

