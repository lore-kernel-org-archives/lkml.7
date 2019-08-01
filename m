Return-Path: <SRS0=wo+8=V5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CBB67C433FF
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Aug 2019 21:39:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 927452084C
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Aug 2019 21:39:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="V/zvbB/f"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732687AbfHAVjf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 1 Aug 2019 17:39:35 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:40933 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726819AbfHAVjf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Aug 2019 17:39:35 -0400
Received: by mail-pl1-f195.google.com with SMTP id a93so32710536pla.7
        for <linux-kernel@vger.kernel.org>; Thu, 01 Aug 2019 14:39:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=HWRnCJIMsVM1IDe22NOvNDUBIkkfPiac8IF2fdxY960=;
        b=V/zvbB/fS34cxNw/RlTGNuMdeOnvJIJb+xi5M+0KO9XgWwKBSWLiUVfk1YF4OrBllV
         xnkGoq669NXIWOHw3+GHp7K+nJwLQwHtEMu6jAProLdidLGDj3LGzMmtCa9fn1Bnq2lS
         vHbPgzHK/76gKtfUY+5CqBppgP8S+mEGbJch4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=HWRnCJIMsVM1IDe22NOvNDUBIkkfPiac8IF2fdxY960=;
        b=CCCswk4KFEu5YcAy1CvFfC9Kes60qLAXnRq9Mw1fhJaZab7MMQkpiOc/hfdFshjnwB
         trlUL3nbOWP4zLL+YY7NoeK2yPWw4JrnuigkOh6jgkVjH4qjdD77zBEEw5mC5gZn82RO
         VszAOquqURx9le64931b4KiyN2eQXvQsYdTNW1r8E7PUSgM5EeiVU2YXhNRlkFiyNYEE
         GsFY8P6MNCpuMJfWtrdzt8pQnGtHYNUQQSMb3OZhAa8BhIEi3VjvuHxjJiSpgDHISVXp
         UuWpAN1qFoW65XdSpaoztfaTgVmZxR/c5AXBkeWWqjr4pGJEBMGUcrsP3GLPcrPYU+Y3
         842Q==
X-Gm-Message-State: APjAAAUT6ybNNiq1X8OB9OquJAb5ftM1WxS1erTWES5abA/hK2LBPxVL
        9isGpU5GJhz4zxWVE5CkkWteBO9v
X-Google-Smtp-Source: APXvYqwmhN7fIg2haJddddsePFQfK8oGbt6GlbJStaXMNJODzawYDPk/u0Cwxeljoz5TaDHNs6XYIg==
X-Received: by 2002:a17:902:7686:: with SMTP id m6mr127992842pll.239.1564695573783;
        Thu, 01 Aug 2019 14:39:33 -0700 (PDT)
Received: from joelaf.cam.corp.google.com ([2620:15c:6:12:9c46:e0da:efbf:69cc])
        by smtp.gmail.com with ESMTPSA id r61sm5940423pjb.7.2019.08.01.14.39.32
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Thu, 01 Aug 2019 14:39:33 -0700 (PDT)
From:   "Joel Fernandes (Google)" <joel@joelfernandes.org>
To:     linux-kernel@vger.kernel.org
Cc:     "Joel Fernandes (Google)" <joel@joelfernandes.org>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        "Paul E. McKenney" <paulmck@linux.ibm.com>, rcu@vger.kernel.org
Subject: [PATCH v2 0/7] Doc updates to /dev branch
Date:   Thu,  1 Aug 2019 17:39:15 -0400
Message-Id: <20190801213922.158860-1-joel@joelfernandes.org>
X-Mailer: git-send-email 2.22.0.770.g0f2c4a37fd-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series fixes the rcu/dev branch with the new ReST conversion patches.

Only changes are to documentation.

thanks,

 - Joel

Joel Fernandes (Google) (6):
Revert docs from "rcu: Restore barrier() to rcu_read_lock() and
rcu_read_unlock()"
Revert docs from "treewide: Rename rcu_dereference_raw_notrace() to
_check()"
docs: rcu: Correct links referring to titles
docs: rcu: Increase toctree to 3
Restore docs "treewide: Rename rcu_dereference_raw_notrace() to
_check()"
Restore docs "rcu: Restore barrier() to rcu_read_lock() and
rcu_read_unlock()"

Mauro Carvalho Chehab (1):
docs: rcu: convert some articles from html to ReST

.../Data-Structures/Data-Structures.html      | 1391 -------
.../Data-Structures/Data-Structures.rst       | 1163 ++++++
.../Expedited-Grace-Periods.html              |  668 ----
.../Expedited-Grace-Periods.rst               |  521 +++
.../Memory-Ordering/Tree-RCU-Diagram.html     |    9 -
.../Tree-RCU-Memory-Ordering.html             |  704 ----
.../Tree-RCU-Memory-Ordering.rst              |  624 +++
.../RCU/Design/Requirements/Requirements.html | 3401 -----------------
.../RCU/Design/Requirements/Requirements.rst  | 2704 +++++++++++++
Documentation/RCU/index.rst                   |    7 +-
Documentation/RCU/whatisRCU.txt               |    4 +-
11 files changed, 5020 insertions(+), 6176 deletions(-)
delete mode 100644 Documentation/RCU/Design/Data-Structures/Data-Structures.html
create mode 100644 Documentation/RCU/Design/Data-Structures/Data-Structures.rst
delete mode 100644 Documentation/RCU/Design/Expedited-Grace-Periods/Expedited-Grace-Periods.html
create mode 100644 Documentation/RCU/Design/Expedited-Grace-Periods/Expedited-Grace-Periods.rst
delete mode 100644 Documentation/RCU/Design/Memory-Ordering/Tree-RCU-Diagram.html
delete mode 100644 Documentation/RCU/Design/Memory-Ordering/Tree-RCU-Memory-Ordering.html
create mode 100644 Documentation/RCU/Design/Memory-Ordering/Tree-RCU-Memory-Ordering.rst
delete mode 100644 Documentation/RCU/Design/Requirements/Requirements.html
create mode 100644 Documentation/RCU/Design/Requirements/Requirements.rst

--
2.22.0.770.g0f2c4a37fd-goog

