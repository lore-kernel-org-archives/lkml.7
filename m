Return-Path: <SRS0=Kqgt=XG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99A04C5ACAE
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Sep 2019 18:02:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 78270208E4
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Sep 2019 18:02:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730001AbfIKSCZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Sep 2019 14:02:25 -0400
Received: from mx1.redhat.com ([209.132.183.28]:55180 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729727AbfIKSCZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Sep 2019 14:02:25 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 0DC983082B40;
        Wed, 11 Sep 2019 18:02:25 +0000 (UTC)
Received: from asgard.redhat.com (ovpn-112-27.ams2.redhat.com [10.36.112.27])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 7A52D19C6A;
        Wed, 11 Sep 2019 18:02:20 +0000 (UTC)
Date:   Wed, 11 Sep 2019 19:01:54 +0100
From:   Eugene Syromiatnikov <esyr@redhat.com>
To:     linux-kernel@vger.kernel.org,
        Christian Brauner <christian@brauner.io>,
        Shuah Khan <shuah@kernel.org>, linux-kselftest@vger.kernel.org
Cc:     Adrian Reber <areber@redhat.com>
Subject: [PATCH v3 0/6] Update clone3 self-tests
Message-ID: <cover.1568224280.git.esyr@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.23 (2014-03-12)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.45]); Wed, 11 Sep 2019 18:02:25 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello.

This patch set updates clone3 selftest in several aspects:
 - adding checks for exit_signal invalid values handling;
 - adding clone3 to selftests targets;
 - enabling clone3 tests on all architectures;
 - minor cleanups of the clone3 test.

This respin alignes additional clone3 self-tests with v3 of the
exit_signal checking patch[1].

Applied on top of brauer/linux.git/for-next.

Changes since v2[2]:
 - CLONE3_ARGS_INVAL_EXIT_SIGNAL_NSIG check is now expected to fail.

Changes since v1[3]:
 - exit_signal check extended to cover more cases of invalid
   exit_signal value.

[1] https://lkml.org/lkml/2019/9/11/677
[2] https://lkml.org/lkml/2019/9/10/768
[3] https://lkml.org/lkml/2019/9/10/416

Eugene Syromiatnikov (6):
  selftests/clone3: convert test modes into an enum
  selftests/clone3: add a check for invalid exit_signal
  selftests/clone3: use uint64_t for flags parameter
  selftests/clone3: fix up format strings
  selftests/clone3: enable clone3 self-tests on all architectures
  selftests: add clone3 to TARGETS

 tools/testing/selftests/Makefile        |  1 +
 tools/testing/selftests/clone3/Makefile |  4 +--
 tools/testing/selftests/clone3/clone3.c | 64 ++++++++++++++++++++++++++++-----
 3 files changed, 57 insertions(+), 12 deletions(-)

-- 
2.1.4

