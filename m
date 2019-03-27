Return-Path: <SRS0=95/N=R6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6632EC4360F
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 11:53:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 38D7D2070D
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 11:53:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728315AbfC0Lxb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Mar 2019 07:53:31 -0400
Received: from mx2.suse.de ([195.135.220.15]:50298 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726262AbfC0Lxa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Mar 2019 07:53:30 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 080AEAEF5;
        Wed, 27 Mar 2019 11:53:29 +0000 (UTC)
Date:   Wed, 27 Mar 2019 12:53:27 +0100
From:   Petr Vorel <pvorel@suse.cz>
To:     Mimi Zohar <zohar@linux.ibm.com>
Cc:     linux-integrity@vger.kernel.org, linux-kselftest@vger.kernel.org,
        kexec@lists.infradead.org, linux-kernel@vger.kernel.org,
        Dave Young <dyoung@redhat.com>,
        Matthew Garrett <mjg59@google.com>
Subject: Re: [PATCH v5 8/9] selftests/kexec: check kexec_load and
 kexec_file_load are enabled
Message-ID: <20190327115327.GB13687@dell5510>
Reply-To: Petr Vorel <pvorel@suse.cz>
References: <1553607257-18906-1-git-send-email-zohar@linux.ibm.com>
 <1553607257-18906-9-git-send-email-zohar@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1553607257-18906-9-git-send-email-zohar@linux.ibm.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mimi, Dave,

> Skip the kexec_load and kexec_file_load tests, if they aren't configured
> in the kernel.  This change adds a new requirement that ikconfig is
> configured in the kexec_load test.

> Suggested-by: Dave Young <dyoung@redhat.com>
> Signed-off-by: Mimi Zohar <zohar@linux.ibm.com>
Reviewed-by: Petr Vorel <pvorel@suse.cz>


Kind regards,
Petr
