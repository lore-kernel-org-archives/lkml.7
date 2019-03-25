Return-Path: <SRS0=yZjE=R4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F035DC43381
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 21:27:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CB4B12070D
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 21:27:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730535AbfCYV1K (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Mar 2019 17:27:10 -0400
Received: from smtprelay0086.hostedemail.com ([216.40.44.86]:50341 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729693AbfCYV1K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Mar 2019 17:27:10 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay07.hostedemail.com (Postfix) with ESMTP id B6988181D341F;
        Mon, 25 Mar 2019 21:27:08 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: brass23_20f9e36b16e4b
X-Filterd-Recvd-Size: 3426
Received: from joe-laptop.perches.com (unknown [47.151.153.53])
        (Authenticated sender: joe@perches.com)
        by omf05.hostedemail.com (Postfix) with ESMTPA;
        Mon, 25 Mar 2019 21:27:06 +0000 (UTC)
From:   Joe Perches <joe@perches.com>
To:     linux-kernel@vger.kernel.org
Cc:     James Bottomley <jejb@linux.ibm.com>,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        Mimi Zohar <zohar@linux.ibm.com>,
        linux-integrity@vger.kernel.org, keyrings@vger.kernel.org,
        Mimi Zohar <zohar@us.ibm.com>,
        David Howells <dhowells@redhat.com>,
        James Morris <jmorris@namei.org>,
        Denis Kenzior <denkenz@gmail.com>,
        Marcel Holtmann <marcel@holtmann.org>,
        James Morris <james.morris@microsoft.com>
Subject: Bad file pattern in MAINTAINERS section 'KEYS-TRUSTED'
Date:   Mon, 25 Mar 2019 14:27:05 -0700
Message-Id: <20190325212705.26837-1-joe@perches.com>
X-Mailer: git-send-email 2.15.0
In-Reply-To: <7cd8d12f59bcacd18a78f599b46dac555f7f16c0.camel@perches.com>
References: <7cd8d12f59bcacd18a78f599b46dac555f7f16c0.camel@perches.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A file pattern line in this section of the MAINTAINERS file in linux-next
does not have a match in the linux source files.

This could occur because a matching filename was never added, was deleted
or renamed in some other commit.

The commits that added and if found renamed or removed the file pattern
are shown below.

Please fix this defect appropriately.

1: ---------------------------------------------------------------------------

linux-next MAINTAINERS section:

	8587	KEYS-TRUSTED
	8588	M:	James Bottomley <jejb@linux.ibm.com>
	8589	M:      Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
	8590	M:	Mimi Zohar <zohar@linux.ibm.com>
	8591	L:	linux-integrity@vger.kernel.org
	8592	L:	keyrings@vger.kernel.org
	8593	S:	Supported
	8594	F:	Documentation/security/keys/trusted-encrypted.rst
	8595	F:	include/keys/trusted-type.h
	8596	F:	security/keys/trusted.c
-->	8597	F:	security/keys/trusted.h

2: ---------------------------------------------------------------------------

The most recent commit that added or modified file pattern 'security/keys/trusted.h':

commit 7f3c68bee977ab872827e44de017216736fe21d7
Author: Mimi Zohar <zohar@linux.vnet.ibm.com>
Date:   Tue Jan 18 09:07:13 2011 -0500

    keys: add trusted and encrypted maintainers
    
    Add myself and David Safford as maintainers for trusted/encrypted keys.
    
    Signed-off-by: Mimi Zohar <zohar@us.ibm.com>
    Acked-by: David Howells <dhowells@redhat.com>
    Signed-off-by: James Morris <jmorris@namei.org>

 MAINTAINERS | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

3: ---------------------------------------------------------------------------

The last commit with a real presence of file pattern 'security/keys/trusted.h':

commit 22447981fc050b5f1bdd0e7cbee89b4152a2b2d8
Author: Denis Kenzior <denkenz@gmail.com>
Date:   Tue Oct 9 17:48:49 2018 +0100

    KEYS: Move trusted.h to include/keys [ver #2]
    
    Signed-off-by: Denis Kenzior <denkenz@gmail.com>
    Signed-off-by: David Howells <dhowells@redhat.com>
    Tested-by: Marcel Holtmann <marcel@holtmann.org>
    Reviewed-by: Marcel Holtmann <marcel@holtmann.org>
    Signed-off-by: James Morris <james.morris@microsoft.com>

 {security => include}/keys/trusted.h | 0
 security/keys/trusted.c              | 2 +-
 2 files changed, 1 insertion(+), 1 deletion(-)
