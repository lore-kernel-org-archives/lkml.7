Return-Path: <SRS0=vI2Y=WC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4957C433FF
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Aug 2019 10:44:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AD6F0214C6
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Aug 2019 10:44:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1565088272;
	bh=RE4LYqyZC3nxGR4DY/hZXh7lFAak3XTUiykn9X5zQGs=;
	h=Date:From:To:cc:Subject:In-Reply-To:References:List-ID:From;
	b=k21RTEmRaT2gHDskZ1TUeKpjHBX4m+1GApm2QEWOeXojdTim4MlW100jysm1W/Pda
	 KMxzKS2w9XKX8hvfIjkGZJjedDn+p38UilzgrO7SdZZzK3tM9HrF2P30EJSM0TWao0
	 9+XEww/5StHYmpWd/FTnXm7k6g6AmnqJ+ko4I9LE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732688AbfHFKob (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 6 Aug 2019 06:44:31 -0400
Received: from mail.kernel.org ([198.145.29.99]:42020 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730068AbfHFKoa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Aug 2019 06:44:30 -0400
Received: from pobox.suse.cz (prg-ext-pat.suse.com [213.151.95.130])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E63852147A;
        Tue,  6 Aug 2019 10:44:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1565088270;
        bh=RE4LYqyZC3nxGR4DY/hZXh7lFAak3XTUiykn9X5zQGs=;
        h=Date:From:To:cc:Subject:In-Reply-To:References:From;
        b=h5Lfg02p2XPxNt0YbSYS0lK7k3nVNbP8ieel9hR9bGBc6D+7ui2q01OrgfFJYykMc
         YSEvvODgoEX4JOjJgHWsLqPk0Ppi4CUNkn6jGZQMETFDSnXbkGXysbKWmWCuN9ISI+
         47zJX4QYkvtDia6MxBQ0DNF2Ns38uKrNZ+dhGjuE=
Date:   Tue, 6 Aug 2019 12:44:25 +0200 (CEST)
From:   Jiri Kosina <jikos@kernel.org>
To:     Hillf Danton <hdanton@sina.com>
cc:     linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
        syzbot <syzbot+62a1e04fd3ec2abf099e@syzkaller.appspotmail.com>,
        Andrey Konovalov <andreyknvl@google.com>
Subject: Re: [PATCH resend 1/2] HID: hiddev: avoid opening a disconnected
 device
In-Reply-To: <20190806083858.8032-1-hdanton@sina.com>
Message-ID: <nycvar.YFH.7.76.1908061244150.27147@cbobk.fhfr.pm>
References: <20190806083858.8032-1-hdanton@sina.com>
User-Agent: Alpine 2.21 (LSU 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Both patches applied, thanks.

-- 
Jiri Kosina
SUSE Labs

