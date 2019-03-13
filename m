Return-Path: <SRS0=dUEL=RQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB5B8C10F03
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Mar 2019 10:14:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 990CA2087C
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Mar 2019 10:14:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726264AbfCMKOj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Mar 2019 06:14:39 -0400
Received: from mx2.suse.de ([195.135.220.15]:52602 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725889AbfCMKOj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Mar 2019 06:14:39 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id DA033ACD7;
        Wed, 13 Mar 2019 10:14:37 +0000 (UTC)
Date:   Wed, 13 Mar 2019 11:14:36 +0100
From:   Petr Vorel <pvorel@suse.cz>
To:     Mimi Zohar <zohar@linux.ibm.com>, Dave Young <dyoung@redhat.com>
Cc:     linux-integrity@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 5/7] selftests/ima: kexec_file_load syscall test
Message-ID: <20190313101436.GB25643@dell5510>
Reply-To: Petr Vorel <pvorel@suse.cz>
References: <1552304473-3966-1-git-send-email-zohar@linux.ibm.com>
 <1552304473-3966-6-git-send-email-zohar@linux.ibm.com>
 <20190312121001.GA18510@dhcp-128-65.nay.redhat.com>
 <1552409474.24794.63.camel@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1552409474.24794.63.camel@linux.ibm.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mimi, Dave,

> > Frankly I did not read and followup much about the testing code changes,
> > not sure if it is doable or not.  The code sharing under testing folder
> > seems not very good.  For example the basic check_root is needed by
> > different parts, but all have its own implementation.  Anyway this is
> > not the duty of this patch set.
> > Also the selftests/lib/ is not a folder for sharing code for different
> > tests, it looks a standalone test instead.
Yes. Thus lib/ folder name is a bit confusing.

> Shuah suggested upstreaming these tests first and defer introducing a
> common set of functions to later.
Make sense.

> > So if split kexec tests to another folder is not doable please just
> > ignore the comment.

> Left in the selftests/ima is a similar test for kernel modules, which
> uses the "common" functions.  So either we wait to move the kexec
> tests or allow them to reach into the ima directory and use the
> ima_common_lib functions.
I guess just load ima_common_lib.sh for now would be good enough.
@Dave: BTW I has starting to work on kselftest common library.
I thought I'd spent some time on it before posting it, but I might even send
the small part I've done so far so we can discuss it.

> > BTW, does CONFIG_KEXEC* is checked?  in case a kernel without KEXEC or
> > KEXEC_FILE compiled in then the tests can just return directly.

> Good point.  Now that there is a common function for reading the
> Kconfig, I'll add that check to both the test_kexec_load.sh and
> test_kexec_file_load.sh tests respectively.

> Mimi


Kind regards,
Petr
