Return-Path: <SRS0=oopU=Z2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41382C43603
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Dec 2019 15:24:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1B1E1207DD
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Dec 2019 15:24:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728276AbfLDPYK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Dec 2019 10:24:10 -0500
Received: from gentwo.org ([3.19.106.255]:46958 "EHLO gentwo.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727828AbfLDPYK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Dec 2019 10:24:10 -0500
Received: by gentwo.org (Postfix, from userid 1002)
        id 8D1393EED9; Wed,  4 Dec 2019 15:24:09 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
        by gentwo.org (Postfix) with ESMTP id 8C3343EBB9;
        Wed,  4 Dec 2019 15:24:09 +0000 (UTC)
Date:   Wed, 4 Dec 2019 15:24:09 +0000 (UTC)
From:   Christopher Lameter <cl@linux.com>
X-X-Sender: cl@www.lameter.com
To:     Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
cc:     Dennis Zhou <dennis@kernel.org>, linux-kernel@vger.kernel.org,
        Tejun Heo <tj@kernel.org>, Nicholas Piggin <npiggin@gmail.com>,
        Ben Dooks <ben.dooks@codethink.co.uk>
Subject: Re: [PATCH v2] fix __percpu annotation in asm-generic
In-Reply-To: <20191204010623.65384-1-luc.vanoostenryck@gmail.com>
Message-ID: <alpine.DEB.2.21.1912041523010.18825@www.lameter.com>
References: <20191204010623.65384-1-luc.vanoostenryck@gmail.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 4 Dec 2019, Luc Van Oostenryck wrote:

> using the fact that typeof() ignores the address space and the
> 'noderef' attribute of its agument.

Acked-by: Christoph Lameter <cl@linux.com>
