Return-Path: <SRS0=g5d9=RD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BABB2C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 23:14:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 912C02133D
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 23:14:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733253AbfB1XOr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Feb 2019 18:14:47 -0500
Received: from mx2.suse.de ([195.135.220.15]:36732 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1732702AbfB1XOo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Feb 2019 18:14:44 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id D3CE1ABA1;
        Thu, 28 Feb 2019 23:14:42 +0000 (UTC)
Date:   Fri, 1 Mar 2019 00:14:41 +0100
From:   Petr Vorel <pvorel@suse.cz>
To:     shuah <shuah@kernel.org>
Cc:     Mimi Zohar <zohar@linux.ibm.com>, linux-kselftest@vger.kernel.org,
        linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 5/5] selftests/ima: loading kernel modules
Message-ID: <20190228231441.GF20335@dell5510>
Reply-To: Petr Vorel <pvorel@suse.cz>
References: <1551223620-11586-1-git-send-email-zohar@linux.ibm.com>
 <1551223620-11586-6-git-send-email-zohar@linux.ibm.com>
 <19d494c6-ecb1-b884-2d23-5f556b3ec05b@kernel.org>
 <1551276893.10911.23.camel@linux.ibm.com>
 <ab45b574-4791-d42a-f566-ab9886525549@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ab45b574-4791-d42a-f566-ab9886525549@kernel.org>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Shuah,

> We can do this as a separate effort in the interest of getting these
> in the interest of getting these in.

> We have common functions in ksefltest.h for c and we don't have them
> for tests scripts. We might be able to collect common routines such
> as get_kconfig into a common .sh and include in tests. If you have time
> to do this, that will be great. It can be done as a separate effort.
Some inspiration, what sort of helpers can be for shell see LTP shell API [1].
These helpers tests help tests to be short, readable and with unified output.
(I like library variables [2] which are self describing and making test even
shorter), setup and cleanup functions called automatically, ...
The same applies for C API [3] (e.g. SAFE_*() helpers for handling errors, ...).

I wonder if there is even any interest of having any sort of helpers or even
framework for shell, when so far there was nothing.

> thanks,
> -- Shuah


Kind regards,
Petr

[1] https://github.com/linux-test-project/ltp/wiki/Test-Writing-Guidelines#23-writing-a-testcase-in-shell
[2] https://github.com/linux-test-project/ltp/wiki/Test-Writing-Guidelines#232-library-variables
[3] https://github.com/linux-test-project/ltp/wiki/Test-Writing-Guidelines#22-writing-a-test-in-c
