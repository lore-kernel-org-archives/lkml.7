Return-Path: <SRS0=FxTY=RO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1C6AC10F06
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 21:51:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8AE7F2147C
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 21:51:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728224AbfCKVvT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Mar 2019 17:51:19 -0400
Received: from mx2.suse.de ([195.135.220.15]:52598 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727008AbfCKVvS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Mar 2019 17:51:18 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 6F22CB12F;
        Mon, 11 Mar 2019 21:51:17 +0000 (UTC)
Date:   Mon, 11 Mar 2019 22:51:15 +0100
From:   Petr Vorel <pvorel@suse.cz>
To:     Mimi Zohar <zohar@linux.ibm.com>
Cc:     linux-integrity@vger.kernel.org, linux-kselftest@vger.kernel.org,
        kexec@lists.infradead.org, linux-kernel@vger.kernel.org,
        Dave Young <dyoung@redhat.com>,
        Matthew Garrett <mjg59@google.com>
Subject: Re: [PATCH v3 0/7] selftests/ima: add kexec and kernel module tests
Message-ID: <20190311215115.GB13024@x230>
Reply-To: Petr Vorel <pvorel@suse.cz>
References: <1552304473-3966-1-git-send-email-zohar@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1552304473-3966-1-git-send-email-zohar@linux.ibm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mimi,

> Mimi Zohar (6):
>   selftests/ima: cleanup the kexec selftest
>   selftests/ima: define a set of common functions
>   selftests/ima: define common logging functions
>   kselftest/ima: define "require_root_privileges"
>   selftests/ima: kexec_file_load syscall test
>   selftests/ima: loading kernel modules
Whole patchset LGTM.
Reviewed-by: Petr Vorel <pvorel@suse.cz>

> Petr Vorel (1):
>   selftests/ima: Add missing '=y' to config options

>  tools/testing/selftests/ima/Makefile               |   3 +-
>  tools/testing/selftests/ima/config                 |   7 +-
>  tools/testing/selftests/ima/ima_common_lib.sh      | 173 +++++++++++++++++++
>  tools/testing/selftests/ima/test_kernel_module.sh  |  93 ++++++++++
>  .../testing/selftests/ima/test_kexec_file_load.sh  | 190 +++++++++++++++++++++
>  tools/testing/selftests/ima/test_kexec_load.sh     |  53 ++----
>  6 files changed, 476 insertions(+), 43 deletions(-)
>  create mode 100755 tools/testing/selftests/ima/ima_common_lib.sh
>  create mode 100755 tools/testing/selftests/ima/test_kernel_module.sh
>  create mode 100755 tools/testing/selftests/ima/test_kexec_file_load.sh


Kind regards,
Petr
