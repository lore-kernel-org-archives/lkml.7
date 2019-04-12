Return-Path: <SRS0=nVcb=SO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51DB7C10F0E
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Apr 2019 14:02:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 221BC206BA
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Apr 2019 14:02:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726898AbfDLOCx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Apr 2019 10:02:53 -0400
Received: from mail-wm1-f54.google.com ([209.85.128.54]:39189 "EHLO
        mail-wm1-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726327AbfDLOCx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Apr 2019 10:02:53 -0400
Received: by mail-wm1-f54.google.com with SMTP id n25so11177897wmk.4;
        Fri, 12 Apr 2019 07:02:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=K2o7QcuRej7Jz5ibxrDXO2Nh1d+Faf/GXRv2kFg1Mtk=;
        b=TNqAr6Ldzx9UzpTdclMRQAbEoOZQCYz0ZoQgv+GDxthfFFjpHQItplp78u8QK0gLBb
         nDUBFa2AYmD0IPKO9H93eDg61gZoU7gBPhWS+Ap9JLu0aWAWENSbVNdD5JKCMYSIloOv
         M60yHELToePWc/6PwMRRR4rZ8hvh5bypYRMBXQjXJnOQxzLvEV5VDpeV7aX3UzCLv6xx
         E66DkRVbe2wrAIMXEEpZaXI79uzfkIg+jshTl9kTUwM/Wcd8OHNp5rUpMYi+n1oMYY4/
         5Qvs8K9Qdt65IusJRmL7ngGBwjK3Qv0uAffR2Zg2/Wg9/MBSWA1bhuNKFtqBUGEyax+K
         7XtA==
X-Gm-Message-State: APjAAAUt9w8f9rrLWSrI9IgXtVFr6l7+5t9SbxS0JB+S3ENPfiE+JIZN
        HnFZfWS4uyTN3qMwy23xDD69c4fDhg==
X-Google-Smtp-Source: APXvYqz7T2fgfgEVmoBZJDFDj6JC4H8dgdYFMeetVCbodd7A62zxlxeceolArLZKPg8EtFE1NtM+YQ==
X-Received: by 2002:a1c:c254:: with SMTP id s81mr10680322wmf.55.1555077769610;
        Fri, 12 Apr 2019 07:02:49 -0700 (PDT)
Received: from box.eng.vmware.com ([146.247.46.5])
        by smtp.gmail.com with ESMTPSA id v184sm15883788wma.6.2019.04.12.07.02.48
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 12 Apr 2019 07:02:48 -0700 (PDT)
From:   Slavomir Kaslev <kaslevs@vmware.com>
To:     mtk.manpages@gmail.com
Cc:     linux-man@vger.kernel.org, linux-kernel@vger.kernel.org,
        slavomir.kaslev@gmail.com
Subject: [PATCH 0/2] Add note on splice/tee EAGAIN error when called with nonblocking descriptors
Date:   Fri, 12 Apr 2019 17:02:45 +0300
Message-Id: <20190412140247.9897-1-kaslevs@vmware.com>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Document that splice(2)/tee(2) can fail with EAGAIN when called with nonblocking
file descriptors and the operation would block.

Slavomir Kaslev (2):
  splice.2: Note EAGAIN can occur when called on nonblocking file
    descriptors
  tee.2: Note EAGAIN can occur when called on nonblocking file
    descriptors

 man2/splice.2 | 4 +++-
 man2/tee.2    | 4 +++-
 2 files changed, 6 insertions(+), 2 deletions(-)

-- 
2.19.1

