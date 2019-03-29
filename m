Return-Path: <SRS0=SA5R=SA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F26CC10F05
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Mar 2019 18:41:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 338832184D
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Mar 2019 18:41:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730072AbfC2SlW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Mar 2019 14:41:22 -0400
Received: from namei.org ([65.99.196.166]:59234 "EHLO namei.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729840AbfC2SlV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Mar 2019 14:41:21 -0400
Received: from localhost (localhost [127.0.0.1])
        by namei.org (8.14.4/8.14.4) with ESMTP id x2TIfJ7x002409;
        Fri, 29 Mar 2019 18:41:19 GMT
Date:   Sat, 30 Mar 2019 05:41:19 +1100 (AEDT)
From:   James Morris <jmorris@namei.org>
To:     Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
cc:     linux-kernel@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        linux-integrity@vger.kernel.org
Subject: Re: [GIT PULL] tpmdd fixes for Linux v5.1
In-Reply-To: <20190329115544.GA27351@linux.intel.com>
Message-ID: <alpine.LRH.2.21.1903300540530.2240@namei.org>
References: <20190329115544.GA27351@linux.intel.com>
User-Agent: Alpine 2.21 (LRH 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 29 Mar 2019, Jarkko Sakkinen wrote:

> Hi James,
> 
> These are critical fixes for v5.1. Contains also couple of new selftests for
> v5.1 features (partial reads in /dev/tpm0). I hope these could still reach
> the release. Thanks.

Applied to 
git://git.kernel.org/pub/scm/linux/kernel/git/jmorris/linux-security.git next-tpm


-- 
James Morris
<jmorris@namei.org>

