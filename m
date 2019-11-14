Return-Path: <SRS0=RWM+=ZG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB97CC432C3
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Nov 2019 14:49:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A48C72070E
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Nov 2019 14:49:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727020AbfKNOtZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Nov 2019 09:49:25 -0500
Received: from youngberry.canonical.com ([91.189.89.112]:40109 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726452AbfKNOtZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Nov 2019 09:49:25 -0500
Received: from [213.220.153.21] (helo=wittgenstein)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <christian.brauner@ubuntu.com>)
        id 1iVGQj-00019H-W7; Thu, 14 Nov 2019 14:49:06 +0000
Date:   Thu, 14 Nov 2019 15:49:05 +0100
From:   Christian Brauner <christian.brauner@ubuntu.com>
To:     Adrian Reber <areber@redhat.com>
Cc:     Eric Biederman <ebiederm@xmission.com>,
        Pavel Emelyanov <ovzxemul@gmail.com>,
        Jann Horn <jannh@google.com>, Oleg Nesterov <oleg@redhat.com>,
        Dmitry Safonov <0x7f454c46@gmail.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        linux-kernel@vger.kernel.org, Andrei Vagin <avagin@gmail.com>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Radostin Stoyanov <rstoyanov1@gmail.com>
Subject: Re: [PATCH v10 2/2] selftests: add tests for clone3() with *set_tid
Message-ID: <20191114144904.cqrun435fkphxk4e@wittgenstein>
References: <20191114142707.1608679-1-areber@redhat.com>
 <20191114142707.1608679-2-areber@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20191114142707.1608679-2-areber@redhat.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 14, 2019 at 03:27:07PM +0100, Adrian Reber wrote:
> This tests clone3() with *set_tid to see if all desired PIDs are working
> as expected. The tests are trying multiple invalid input parameters as
> well as creating processes while specifying a certain PID in multiple
> PID namespaces at the same time.
> 
> Additionally this moves common clone3() test code into clone3_selftests.h.
> 
> Signed-off-by: Adrian Reber <areber@redhat.com>

Thanks, Adrian!
Acked-by: Christian Brauner <christian.brauner@ubuntu.com>
