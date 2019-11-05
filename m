Return-Path: <SRS0=2+op=Y5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F373C2BAEF
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Nov 2019 08:56:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EDE48214D8
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Nov 2019 08:56:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1572944195;
	bh=HLIr/WBriOy2Gkw0WCFXEClvRwKI77QU/sr2QCvzKhU=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=fd/KYcb2wSuFhIeK/iTIqMB7J+eVfzPu20zmePmZT/uxVDO/DueS4PaQ2MbW5121g
	 HfSFYtV1QCGFVw3hI0CYsCu66ZmvH6q6GChwJ2Ba4PFnkcTqdTL1sCc/bafe1iaGLE
	 l+mUGAmQ9yUD/6t39ysSYlGMmFSM+OkYI/Omb3AI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730628AbfKEI4e (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Nov 2019 03:56:34 -0500
Received: from mail-lj1-f173.google.com ([209.85.208.173]:37311 "EHLO
        mail-lj1-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729765AbfKEI4d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Nov 2019 03:56:33 -0500
Received: by mail-lj1-f173.google.com with SMTP id l20so2178348lje.4;
        Tue, 05 Nov 2019 00:56:32 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=iwXTCihe08fT2qb1oY0hZ3FiCBKTyxRiFtyESLVzA0Q=;
        b=mEww4Fnoms7SN9KKmx1gYmtt2nkrUneluMn3ITDZ33D0oQdMYqyka4j7pKmLj8BHyr
         JKTtBfiVyQ7dRoUxcC+2EfNFWzuXxdqEb6nIV4E+GmfXK7nIw7c+aI0Trge9X04vDu9F
         4xiR+0L30kxWuPKAtIU7Pgh5/pMCkgQDVzQvYAsLGyf2FKsM6CQE7WuYDwpEyKUg1KVC
         rS7e25O/XCOHHHpF42i5qOKw9dtXknlOu6dk9GjdmvDNdy4hCH3ux0Xj1wMk3qheJ+1M
         /xPLRB0MMRKldE94jd68d2BfYQuwvztx3RNSqxb83LIxOwyVh7tNf/eqF2gh9iLOXoAn
         zPZw==
X-Gm-Message-State: APjAAAVEvN3hLuzTFjGO76tonDx64T7k6ENTTLbOZnjfr7S+qUx243eE
        vPjqWl1cGRxCZRB5EHhxR6s=
X-Google-Smtp-Source: APXvYqyUI9lrtaQ/WfC01q/AYKK0eHEDc6+uZ/JfjUk0ddRnWNCSul25+GyeKWPgLjxHtg/bFqR61A==
X-Received: by 2002:a2e:894b:: with SMTP id b11mr2240500ljk.118.1572944191582;
        Tue, 05 Nov 2019 00:56:31 -0800 (PST)
Received: from xi.terra (c-51f1e055.07-184-6d6c6d4.bbcust.telenor.se. [85.224.241.81])
        by smtp.gmail.com with ESMTPSA id v21sm6435046ljh.53.2019.11.05.00.56.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Nov 2019 00:56:30 -0800 (PST)
Received: from johan by xi.terra with local (Exim 4.92.3)
        (envelope-from <johan@xi.terra>)
        id 1iRuda-0000ci-Cg; Tue, 05 Nov 2019 09:56:30 +0100
From:   Johan Hovold <johan@kernel.org>
To:     "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>
Cc:     YOKOTA Hiroshi <yokota@netlab.is.tsukuba.ac.jp>,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        Johan Hovold <johan@kernel.org>
Subject: [PATCH 0/2] scsi: nsp_cs: MODULE_LICENSE clean up and compile test
Date:   Tue,  5 Nov 2019 09:56:07 +0100
Message-Id: <20191105085609.2338-1-johan@kernel.org>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We had two drivers in the tree needlessly checking whether
MODULE_LICENSE was defined, this fixes the second one.

In order to compile test this on a 64-bit machine I added COMPILE_TEST
to the current !64BIT dependency.

Johan


Johan Hovold (2):
  scsi: nsp_cs: drop redundant MODULE_LICENSE ifdef
  scsi: nsp_cs: enable compile-testing on 64-bit

 drivers/scsi/pcmcia/Kconfig  | 2 +-
 drivers/scsi/pcmcia/nsp_cs.c | 2 --
 2 files changed, 1 insertion(+), 3 deletions(-)

-- 
2.23.0

