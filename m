Return-Path: <SRS0=qJmF=WX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB083C3A5A3
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Aug 2019 07:59:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7F06422CBB
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Aug 2019 07:59:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1566892742;
	bh=w9n+0IkPLMXp12/EI3ePqqrQeWYE9NsYwoEcxGk5xxE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=E3rfx2dxuENv7j7Vq5nzHnBZF9ceLgc797nuri36SUqdwenhW2Rqy1CKoLDROLDGO
	 0mk1ipIMtFNWcTRBNSXYqQIEreXB3zTJnC0+5gqVWRQDpWxHZ9tqHSvKjW4FMarVBn
	 9KVQcJfozMW63MDkPAdyYEAzSDmcnJ7phvdAdtqU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729788AbfH0H7B (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 27 Aug 2019 03:59:01 -0400
Received: from mail.kernel.org ([198.145.29.99]:51770 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731074AbfH0H6r (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Aug 2019 03:58:47 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 095AD20828;
        Tue, 27 Aug 2019 07:58:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1566892726;
        bh=w9n+0IkPLMXp12/EI3ePqqrQeWYE9NsYwoEcxGk5xxE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=DsjtRE86jODgMh3q86/Zknr7mx970LuEnjMn7a+ZNrlIcjX4aI5qAkmJPITTgV7X1
         mVZ4++X574iU2IgRIoiOKejA5xq1FvzM1zjyqhL6CHFEYCsyV+AGHdwVZvQM6GZlna
         NuvK5lLA/JMgvUOeYHnUUKSfCqpwL70f2dA6lKlo=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Allison Henderson <allison.henderson@oracle.com>,
        Dave Chinner <dchinner@redhat.com>,
        Dave Chinner <david@fromorbit.com>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 90/98] xfs: Move fs/xfs/xfs_attr.h to fs/xfs/libxfs/xfs_attr.h
Date:   Tue, 27 Aug 2019 09:51:09 +0200
Message-Id: <20190827072722.840655823@linuxfoundation.org>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20190827072718.142728620@linuxfoundation.org>
References: <20190827072718.142728620@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

commit e2421f0b5ff3ce279573036f5cfcb0ce28b422a9 upstream.

This patch moves fs/xfs/xfs_attr.h to fs/xfs/libxfs/xfs_attr.h
since xfs_attr.c is in libxfs.  We will need these later in
xfsprogs.

Signed-off-by: Allison Henderson <allison.henderson@oracle.com>
Reviewed-by: Dave Chinner <dchinner@redhat.com>
Signed-off-by: Dave Chinner <david@fromorbit.com>
Signed-off-by: Luis Chamberlain <mcgrof@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/xfs/{ => libxfs}/xfs_attr.h | 0
 1 file changed, 0 insertions(+), 0 deletions(-)
 rename fs/xfs/{ => libxfs}/xfs_attr.h (100%)

diff --git a/fs/xfs/xfs_attr.h b/fs/xfs/libxfs/xfs_attr.h
similarity index 100%
rename from fs/xfs/xfs_attr.h
rename to fs/xfs/libxfs/xfs_attr.h
-- 
2.20.1



