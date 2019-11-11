Return-Path: <SRS0=camR=ZD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91E0FC43331
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Nov 2019 14:44:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 66BD8222BD
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Nov 2019 14:44:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chrisdown.name header.i=@chrisdown.name header.b="OS76QWxr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727241AbfKKOom (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Nov 2019 09:44:42 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:51676 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726871AbfKKOol (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Nov 2019 09:44:41 -0500
Received: by mail-wm1-f66.google.com with SMTP id q70so13617644wme.1
        for <linux-kernel@vger.kernel.org>; Mon, 11 Nov 2019 06:44:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chrisdown.name; s=google;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=jpUzAZEpApOMVMIW0Fqf4/xrL7Q7nYI9jKjTWCa/2z8=;
        b=OS76QWxrRsPKqu6mUeCbMb9Joyk0TTB7Vdtx082xBJahs8lh9PNXAOwoS8XFicAgnI
         S/inQqa37xoc1IvkPXcEYEx81Bda9cHzMfpc6CFPjL+XDAaptyTPwCVnrscdIIwD1Bcc
         L8WJGGl/hHN28w0gmLwzm7pWVT5CtEgO2zfj0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=jpUzAZEpApOMVMIW0Fqf4/xrL7Q7nYI9jKjTWCa/2z8=;
        b=Qo9jxFucjWp9gsPJi2IL5JPKDzu4lH359F2nXF+MyojzXY/fiwZ7cW627X0k1kY7yM
         Y7PNU9dXq/ZhiBhB8K1uyIg7t+ewwqjofxv07/1MxguKuiZjDG8t0kSLqjTQZHZ69fUZ
         qWmyGp+E30n9VRuniwwIT5mysM51Aam6HA0kH4f1ZRxvcSCq9ZGf7p/9cKItdDUjDe2P
         9P/YMRAoXIM9Hh1lGcTOZ80GhGRkc139cGW1P/bbjiLBpodBGASDykWHsZJ5eQ6t9XXu
         yyy/X7zXzNexOjGlzdhG4l2Q3VEEaV4ExiJhv2LI3kg2O4AP7cH3XhPfVleJD6RNHhId
         Rd4g==
X-Gm-Message-State: APjAAAVqZPaioVBW1qW3OHbaQ8W66Y1Oo9TiCYxPzn6pISWK7PfzzbAO
        Xk2cbRB/1wdxC2S7qMmdXxt7hVn6gOM=
X-Google-Smtp-Source: APXvYqwNzJJfn5BWH0Qn+AAZlUvMuNy+Dst6UH30y5ZNHAIU1t3O2wV8umKCGn0kc/pyjW9LijsBXw==
X-Received: by 2002:a1c:7f94:: with SMTP id a142mr19888187wmd.33.1573483479073;
        Mon, 11 Nov 2019 06:44:39 -0800 (PST)
Received: from localhost ([2620:10d:c092:180::1:3e35])
        by smtp.gmail.com with ESMTPSA id p4sm18608305wrx.71.2019.11.11.06.44.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Nov 2019 06:44:38 -0800 (PST)
Date:   Mon, 11 Nov 2019 14:44:38 +0000
From:   Chris Down <chris@chrisdown.name>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, cgroups@vger.kernel.org,
        linux-mm@kvack.org, kernel-team@fb.com
Subject: [PATCH] docs: cgroup: mm: Fix spelling of "list"
Message-ID: <20191111144438.GA11327@chrisdown.name>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Chris Down <chris@chrisdown.name>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org
Cc: cgroups@vger.kernel.org
Cc: linux-mm@kvack.org
Cc: kernel-team@fb.com
---
 Documentation/admin-guide/cgroup-v2.rst | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/admin-guide/cgroup-v2.rst b/Documentation/admin-guide/cgroup-v2.rst
index ed9123155e03..0704552ed94f 100644
--- a/Documentation/admin-guide/cgroup-v2.rst
+++ b/Documentation/admin-guide/cgroup-v2.rst
@@ -1335,7 +1335,7 @@ PAGE_SIZE multiple when read back.
 
 	  pgdeactivate
 
-		Amount of pages moved to the inactive LRU lis
+		Amount of pages moved to the inactive LRU list
 
 	  pglazyfree
 
-- 
2.24.0

