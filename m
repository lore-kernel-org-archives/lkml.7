Return-Path: <SRS0=Pa1K=VP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58EE6C76196
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jul 2019 07:37:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3A6472173B
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jul 2019 07:37:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389232AbfGRHhB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Jul 2019 03:37:01 -0400
Received: from mx1.redhat.com ([209.132.183.28]:49432 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726397AbfGRHhA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Jul 2019 03:37:00 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 7F92B300CB25;
        Thu, 18 Jul 2019 07:37:00 +0000 (UTC)
Received: from localhost (unknown [10.40.205.12])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 2822360C44;
        Thu, 18 Jul 2019 07:36:55 +0000 (UTC)
Date:   Thu, 18 Jul 2019 09:36:54 +0200
From:   Jiri Benc <jbenc@redhat.com>
To:     Sasha Levin <sashal@kernel.org>
Cc:     linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        Yonghong Song <yhs@fb.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        linux-kselftest@vger.kernel.org, netdev@vger.kernel.org,
        bpf@vger.kernel.org, clang-built-linux@googlegroups.com
Subject: Re: [PATCH AUTOSEL 5.2 226/249] selftests: bpf: fix inlines in
 test_lwt_seg6local
Message-ID: <20190718093654.0a3426f5@redhat.com>
In-Reply-To: <20190717234757.GD3079@sasha-vm>
References: <20190715134655.4076-1-sashal@kernel.org>
        <20190715134655.4076-226-sashal@kernel.org>
        <20190717114334.5556a14e@redhat.com>
        <20190717234757.GD3079@sasha-vm>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.46]); Thu, 18 Jul 2019 07:37:00 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 17 Jul 2019 19:47:57 -0400, Sasha Levin wrote:
> It fixes a bug, right?

A bug in selftests. And quite likely, it probably happens only with
some compiler versions.

I don't think patches only touching tools/testing/selftests/ qualify
for stable in general. They don't affect the end users.

 Jiri
