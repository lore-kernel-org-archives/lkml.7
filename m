Return-Path: <SRS0=OzJr=YZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB5C8CA9ECF
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Nov 2019 11:25:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B510120656
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Nov 2019 11:25:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1572607515;
	bh=f7z50vaHptEB/IsdALtjYC+75XPYhMyFj3b0kyhw/kE=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=spWbVxbvyOe7yUO8vlUl9/YM8FfRYZk9y1k0NFVw4FvvAUuJkM636yqfgCqjFHo47
	 wEGy3Cq30XN7dsT06lSB/4SiJJQacAY8gADyAuYScFYuPlv4adwu+iZuNF1udjjt3v
	 EXN96BYZgc5YGdy0EjP+OC/QCvN3bA0HSE0DCmOg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730447AbfKALZO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 Nov 2019 07:25:14 -0400
Received: from mail-lf1-f47.google.com ([209.85.167.47]:37674 "EHLO
        mail-lf1-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726663AbfKALZO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Nov 2019 07:25:14 -0400
Received: by mail-lf1-f47.google.com with SMTP id b20so6991737lfp.4;
        Fri, 01 Nov 2019 04:25:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=vUQnbyGeROcbfx3shdHmEtVSfcZgw+KlZ0MXbPBb4sU=;
        b=ho8lgjddR2BzrrljLsqjcmCNttQHQlUGepjQShW8k7o0pmsa6NpF1nauFGh4RdRtVP
         osCjnqBBlImBSg/QbwhMHFw8/P+x1wVDh+i8H+nrDnBFr+HktNu5vhK3WeyyWX/suYFB
         pAx2S6dkKE5K0LOI8uAfzJXEXan0EHZwWM3mCoRIcDHOp53FU4aW9pDMGT9McPMWr/7R
         pM5X1CKlWnhHs/fFHbetfh0oEJaIKAsrJ/CXZkKOpSZzSj2dKHlzYet8KTsFZYSNJwNz
         ZyPkIspsIUvVEXlZO16Q0FVg3MVz+dc+3hTNVQyJr3JAGsi/kaPItkgjsrYc9suajmAX
         ya5A==
X-Gm-Message-State: APjAAAUrMMFe4EQ1sBJl8ZN9NAVcG7J6hXWSXj5qikDxg3AiydC2Vb28
        +Ti8UcHEEf9hh1CnUt9xIJV1QFrXy10=
X-Google-Smtp-Source: APXvYqwFqJsvRt95nTuIgux0lgecAnc4aTglAav6UTMlfC+qmYRzbvc6khqU7ehvt8SJCfxN5gZpCA==
X-Received: by 2002:a19:ac48:: with SMTP id r8mr7289820lfc.181.1572607511591;
        Fri, 01 Nov 2019 04:25:11 -0700 (PDT)
Received: from neopili.qtec.com (cpe.xe-3-0-1-778.vbrnqe10.dk.customer.tdc.net. [80.197.57.18])
        by smtp.gmail.com with ESMTPSA id u13sm1851775ljl.71.2019.11.01.04.25.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Nov 2019 04:25:10 -0700 (PDT)
From:   Ricardo Ribalda Delgado <ribalda@kernel.org>
To:     Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Ricardo Ribalda Delgado <ribalda@kernel.org>
Subject: [PATCH 1/4] HEADERS, do not merge!!!!
Date:   Fri,  1 Nov 2019 12:25:06 +0100
Message-Id: <20191101112509.29723-1-ribalda@kernel.org>
X-Mailer: git-send-email 2.24.0.rc1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

---
 contrib/freebsd/include/linux/videodev2.h | 1 +
 include/linux/videodev2.h                 | 1 +
 2 files changed, 2 insertions(+)

diff --git a/contrib/freebsd/include/linux/videodev2.h b/contrib/freebsd/include/linux/videodev2.h
index 85fa80f7..e90c8912 100644
--- a/contrib/freebsd/include/linux/videodev2.h
+++ b/contrib/freebsd/include/linux/videodev2.h
@@ -1713,6 +1713,7 @@ struct v4l2_ext_control {
 		uint16_t *p_u16;
 		uint32_t *p_u32;
 		void *ptr;
+		struct v4l2_area *p_area;
 	};
 } __attribute__ ((packed));
 
diff --git a/include/linux/videodev2.h b/include/linux/videodev2.h
index 6d66a789..7bafe5cd 100644
--- a/include/linux/videodev2.h
+++ b/include/linux/videodev2.h
@@ -1678,6 +1678,7 @@ struct v4l2_ext_control {
 		__u8 *p_u8;
 		__u16 *p_u16;
 		__u32 *p_u32;
+		struct v4l2_area *p_area;
 		void *ptr;
 	};
 } __attribute__ ((packed));
-- 
2.24.0.rc1

