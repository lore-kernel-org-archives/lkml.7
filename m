Return-Path: <SRS0=g5d9=RD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9660C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 19:54:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C60C0218AE
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 19:54:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388038AbfB1Tyj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Feb 2019 14:54:39 -0500
Received: from mx2.suse.de ([195.135.220.15]:48636 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726231AbfB1Tyi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Feb 2019 14:54:38 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 79E0AAFB8;
        Thu, 28 Feb 2019 19:54:37 +0000 (UTC)
Date:   Thu, 28 Feb 2019 20:54:35 +0100
From:   Petr Vorel <pvorel@suse.cz>
To:     Mimi Zohar <zohar@linux.ibm.com>
Cc:     linux-kselftest@vger.kernel.org, Shuah Khan <shuah@kernel.org>,
        linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/5] selftests/ima: define a set of common functions
Message-ID: <20190228195435.GA20335@dell5510>
Reply-To: Petr Vorel <pvorel@suse.cz>
References: <1551223620-11586-1-git-send-email-zohar@linux.ibm.com>
 <1551223620-11586-3-git-send-email-zohar@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1551223620-11586-3-git-send-email-zohar@linux.ibm.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mimi,

> Define, update and move get_secureboot_mode() to a common file for use
> by other tests.

> Signed-off-by: Mimi Zohar <zohar@linux.ibm.com>
Reviewed-by: Petr Vorel <pvorel@suse.cz>

...
>  ifeq ($(ARCH),x86)
>  TEST_PROGS := test_kexec_load.sh
> +TEST_FILES := common_lib.sh
In case there might be some common library for whole selftest, I'd name this ima_lib.sh.
(even it won't be in the same directory it might be better for readability).

>  include ../lib.mk

> diff --git a/tools/testing/selftests/ima/common_lib.sh b/tools/testing/selftests/ima/common_lib.sh
> new file mode 100755
> index 000000000000..5583ea74c14e
> --- /dev/null
> +++ b/tools/testing/selftests/ima/common_lib.sh
> @@ -0,0 +1,24 @@
> +#!/bin/sh
> +# SPDX-License-Identifier: GPL-2.0-or-later
I'm sorry, that was me who advised GPL v2+ instead of GPL v2 only :).

...

Kind regards,
Petr
