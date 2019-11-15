Return-Path: <SRS0=19dG=ZH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07C95C43141
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Nov 2019 10:06:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DF8BF2073A
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Nov 2019 10:06:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727848AbfKOKGg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Nov 2019 05:06:36 -0500
Received: from cloudserver094114.home.pl ([79.96.170.134]:45985 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727036AbfKOKGf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Nov 2019 05:06:35 -0500
Received: from 79.184.253.153.ipv4.supernova.orange.pl (79.184.253.153) (HELO kreacher.localnet)
 by serwer1319399.home.pl (79.96.170.134) with SMTP (IdeaSmtpServer 0.83.292)
 id eaf467d23101dae7; Fri, 15 Nov 2019 11:06:33 +0100
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Zhenzhong Duan <zhenzhong.duan@oracle.com>
Cc:     linux-kernel@vger.kernel.org, pbonzini@redhat.com,
        rkrcmar@redhat.com, rafael.j.wysocki@intel.com,
        joao.m.martins@oracle.com, mtosatti@redhat.com,
        kvm@vger.kernel.org, linux-pm@vger.kernel.org
Subject: Re: [PATCH RESEND v2 1/4] cpuidle-haltpoll: ensure grow start value is nonzero
Date:   Fri, 15 Nov 2019 11:06:32 +0100
Message-ID: <2090510.mhlLnX9yIq@kreacher>
In-Reply-To: <1573041302-4904-2-git-send-email-zhenzhong.duan@oracle.com>
References: <1573041302-4904-1-git-send-email-zhenzhong.duan@oracle.com> <1573041302-4904-2-git-send-email-zhenzhong.duan@oracle.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday, November 6, 2019 12:54:59 PM CET Zhenzhong Duan wrote:
> dev->poll_limit_ns could be zeroed in certain cases (e.g. by
> guest_halt_poll_ns = 0). If guest_halt_poll_grow_start is zero,
> dev->poll_limit_ns will never be bigger than zero.

Given that haltpoll_enable_device() sets dev->poll_limit_ns = 0 to start with,
I don't think that the statement above is correct.



