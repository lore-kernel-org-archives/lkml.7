Return-Path: <SRS0=zem1=X3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2BF7EC35280
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Oct 2019 15:28:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0326321D7B
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Oct 2019 15:28:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="BaDPoJQQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728863AbfJBP2s (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 2 Oct 2019 11:28:48 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:39034 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727308AbfJBP2s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Oct 2019 11:28:48 -0400
Received: by mail-pf1-f194.google.com with SMTP id v4so10527818pff.6
        for <linux-kernel@vger.kernel.org>; Wed, 02 Oct 2019 08:28:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=LmPSSnl7oLfjGfTevWKF5nXawA8GgW4CyXCX6bgUzQ4=;
        b=BaDPoJQQVln/hwSWT1CTz1bja93uK6DzuCN8vMSY2Ybiq8MaGIDAypfNlUNnyp+fok
         2kMXuT+NUuvlomBUbRn5X7HXLNPNKvCtZ+/y1P0hSXI08oncay2zGvrX6rQ1VMeMgC+1
         QY30hPdub0KcRJlSo5KnElf61FhY5nXbdd99Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=LmPSSnl7oLfjGfTevWKF5nXawA8GgW4CyXCX6bgUzQ4=;
        b=BSTP2E7AdKJ4EpDNfgWlKTrn4GyEFtHW5MoTaI+kVr8AgU9Ak8OrSoYOW7YyYFm/6h
         oREFUq+ydh08uXYOdOtvh2UpJoLfeGIE8YY0khjBuo3zbWE+KSDp1vCjneChD4WnGQRJ
         v8TjxpP99SyBbZGKjeWcp6bjRNJJ3MyRL3ZBd1qb/HiyHXyebeLh+bzSPPCGO828t8gj
         1D6N6ULwbEN9BvwXpqaXowDKiueMNVuGfOLf+d68hn+jKNdZ37ov1d1jkYq91Mbzsu/T
         YVbyW2/3lT2iKB855i+Qg6WW/QB1zYg9carzhVI1aBfT+4fsdewSQHzCL/B34dn5MyVt
         EgkQ==
X-Gm-Message-State: APjAAAW/8DBablhxBgN2TjYyy+ZDqTMu7mp4m2LGwfo1w8fu4RzqGMW5
        4IMqA3RKycSzVUyKLQYrPiz0JeKKZr8=
X-Google-Smtp-Source: APXvYqwAoQvOz21uGWIZpseoql17b2IzK7tPeAurYqQtFfTgTH/bfDoI3eQhpHuCdzlQlW4B+qWbfg==
X-Received: by 2002:a65:534a:: with SMTP id w10mr4318773pgr.375.1570030126903;
        Wed, 02 Oct 2019 08:28:46 -0700 (PDT)
Received: from joelaf.cam.corp.google.com ([2620:15c:6:12:9c46:e0da:efbf:69cc])
        by smtp.gmail.com with ESMTPSA id c8sm18647245pgw.37.2019.10.02.08.28.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Oct 2019 08:28:46 -0700 (PDT)
From:   "Joel Fernandes (Google)" <joel@joelfernandes.org>
To:     linux-kernel@vger.kernel.org
Cc:     "Joel Fernandes (Google)" <joel@joelfernandes.org>,
        Paul McKenney <paulmck@kernel.org>,
        Alan Stern <stern@rowland.harvard.edu>,
        "David S. Miller" <davem@davemloft.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Rob Herring <robh@kernel.org>
Subject: [PATCH] MAINTAINERS: Add me for Linux Kernel memory consistency model (LKMM)
Date:   Wed,  2 Oct 2019 11:28:37 -0400
Message-Id: <20191002152837.97191-1-joel@joelfernandes.org>
X-Mailer: git-send-email 2.23.0.444.g18eeb5a265-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quite interested in the LKMM, I have submitted patches before and used
it a lot. I would like to be a part of the maintainers for this project.

Cc: Paul McKenney <paulmck@kernel.org>
Suggested-by: Alan Stern <stern@rowland.harvard.edu>
Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>

---
 MAINTAINERS | 1 +
 1 file changed, 1 insertion(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 296de2b51c83..ecf6d265a88d 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -9473,6 +9473,7 @@ M:	David Howells <dhowells@redhat.com>
 M:	Jade Alglave <j.alglave@ucl.ac.uk>
 M:	Luc Maranget <luc.maranget@inria.fr>
 M:	"Paul E. McKenney" <paulmck@kernel.org>
+M:	Joel Fernandes <joel@joelfernandes.org>
 R:	Akira Yokosawa <akiyks@gmail.com>
 R:	Daniel Lustig <dlustig@nvidia.com>
 L:	linux-kernel@vger.kernel.org
-- 
2.23.0.444.g18eeb5a265-goog

