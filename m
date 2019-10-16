Return-Path: <SRS0=S2At=YJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7175FA3728
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Oct 2019 14:38:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 841B12067D
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Oct 2019 14:38:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404944AbfJPOiG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 16 Oct 2019 10:38:06 -0400
Received: from gentwo.org ([3.19.106.255]:48200 "EHLO gentwo.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2404542AbfJPOiG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Oct 2019 10:38:06 -0400
Received: by gentwo.org (Postfix, from userid 1002)
        id 80DB83F1C2; Wed, 16 Oct 2019 14:38:05 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
        by gentwo.org (Postfix) with ESMTP id 800B53E939;
        Wed, 16 Oct 2019 14:38:05 +0000 (UTC)
Date:   Wed, 16 Oct 2019 14:38:05 +0000 (UTC)
From:   Christopher Lameter <cl@linux.com>
X-X-Sender: cl@www.lameter.com
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
cc:     linux-kernel@vger.kernel.org, tglx@linutronix.de,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org
Subject: Re: [PATCH 25/34] mm: Use CONFIG_PREEMPTION
In-Reply-To: <20191015191821.11479-26-bigeasy@linutronix.de>
Message-ID: <alpine.DEB.2.21.1910161437310.12925@www.lameter.com>
References: <20191015191821.11479-1-bigeasy@linutronix.de> <20191015191821.11479-26-bigeasy@linutronix.de>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Acked-by: Chistoph Lameter <cl@linux.com>
