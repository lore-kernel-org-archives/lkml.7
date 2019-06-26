Return-Path: <SRS0=hRvo=UZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20909C48BD6
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Jun 2019 17:36:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F40392080C
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Jun 2019 17:35:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726595AbfFZRf7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Jun 2019 13:35:59 -0400
Received: from ms.lwn.net ([45.79.88.28]:40904 "EHLO ms.lwn.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726487AbfFZRf4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jun 2019 13:35:56 -0400
Received: from meer.lwn.net (localhost [127.0.0.1])
        by ms.lwn.net (Postfix) with ESMTPA id 5D1554BF;
        Wed, 26 Jun 2019 17:29:10 +0000 (UTC)
From:   Jonathan Corbet <corbet@lwn.net>
To:     linux-doc@vger.kernel.org
Cc:     Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>
Subject: [PATCH v3 0/4] docs: Automatically mark up function references
Date:   Wed, 26 Jun 2019 11:28:55 -0600
Message-Id: <20190626172859.16113-1-corbet@lwn.net>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

For the record, I hope that this is the version I will actually merge.  It
adds an extension to automatically recognize references to functions and
create cross references for them, eliminating the need to use the unsightly
:c:func:``function`` notation.

Since v2 little has happened:
  - Expand the skip list of system-call names that we shouldn't even
    try to mark up.
  - Improve the comments in the extension code slightly
  - Add a paragraph to the doc-guide discouraging use of :c:func:

Jonathan Corbet (4):
  Docs: An initial automarkup extension for sphinx
  docs: remove :c:func: annotations from xarray.rst
  kernel-doc: Don't try to mark up function names
  docs: Note that :c:func: should no longer be used

 Documentation/conf.py              |   3 +-
 Documentation/core-api/xarray.rst  | 270 ++++++++++++++---------------
 Documentation/doc-guide/sphinx.rst |  13 +-
 Documentation/sphinx/automarkup.py |  93 ++++++++++
 scripts/kernel-doc                 |   2 +-
 5 files changed, 239 insertions(+), 142 deletions(-)
 create mode 100644 Documentation/sphinx/automarkup.py

-- 
2.21.0

