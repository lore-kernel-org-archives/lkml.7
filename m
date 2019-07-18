Return-Path: <SRS0=Pa1K=VP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D709C7618F
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jul 2019 18:52:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6A02A21872
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jul 2019 18:52:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391020AbfGRSwZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Jul 2019 14:52:25 -0400
Received: from shards.monkeyblade.net ([23.128.96.9]:54110 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727762AbfGRSwZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Jul 2019 14:52:25 -0400
Received: from localhost (unknown [IPv6:2601:601:9f80:35cd::d71])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id EA3A91527BF0E;
        Thu, 18 Jul 2019 11:52:24 -0700 (PDT)
Date:   Thu, 18 Jul 2019 11:52:24 -0700 (PDT)
Message-Id: <20190718.115224.1933823583893054221.davem@davemloft.net>
To:     suyj.fnst@cn.fujitsu.com
Cc:     kuznet@ms2.inr.ac.ru, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] udp: Fix typo in net/ipv4/udp.c
From:   David Miller <davem@davemloft.net>
In-Reply-To: <1563416363-7036-1-git-send-email-suyj.fnst@cn.fujitsu.com>
References: <1563416363-7036-1-git-send-email-suyj.fnst@cn.fujitsu.com>
X-Mailer: Mew version 6.8 on Emacs 26.1
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Thu, 18 Jul 2019 11:52:25 -0700 (PDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Su Yanjun <suyj.fnst@cn.fujitsu.com>
Date: Thu, 18 Jul 2019 10:19:23 +0800

> Signed-off-by: Su Yanjun <suyj.fnst@cn.fujitsu.com>

Several problems with this patch submission:

1) Please always make it clear when you post a new version of a patch
   using indications in the Subject line such as "[PATCH v2]" or
   similar.

   Otherwise I assume it is a different change altogether and not
   related to any other patch.

2) The targetted subsystem or tree must be clearly identified in the
   subject line, for this you should say "[PATCH net v2]" since you
   are targetting my networking bug fix GIT tree.

Thank you.
