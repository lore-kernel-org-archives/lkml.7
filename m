Return-Path: <SRS0=K9bG=V2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF7C4C433FF
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jul 2019 15:18:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D03F321655
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jul 2019 15:18:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387953AbfG2PSM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Jul 2019 11:18:12 -0400
Received: from mx2.suse.de ([195.135.220.15]:57612 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2387693AbfG2PSL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jul 2019 11:18:11 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 778E4AD17;
        Mon, 29 Jul 2019 15:18:10 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Mon, 29 Jul 2019 08:18:10 -0700
From:   Davidlohr Bueso <dbueso@suse.de>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Will Deacon <will@kernel.org>, linux-kernel@vger.kernel.org,
        Jan Stancek <jstancek@redhat.com>,
        Waiman Long <longman@redhat.com>, mingo@redhat.com,
        jade.alglave@arm.com, paulmck@linux.vnet.ibm.com
Subject: Re: [PATCH 0/4] Various rwsem ACQUIRE fixes
Organization: SUSE Labs
In-Reply-To: <20190718134954.496297975@infradead.org>
References: <20190718134954.496297975@infradead.org>
Message-ID: <cc546d20114d7db8484e9adc8153a327@suse.de>
X-Sender: dbueso@suse.de
User-Agent: Roundcube Webmail
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2019-07-18 06:49, Peter Zijlstra wrote:
> These are the patches I ended up with after we started with Jan's
> patch (edited).

This series looks good to me.

Acked-by: Davidlohr Bueso <dbueso@suse.de>
