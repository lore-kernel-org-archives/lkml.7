Return-Path: <SRS0=KBKa=UT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EEECDC43613
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Jun 2019 09:45:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B4D572083B
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Jun 2019 09:45:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=web.de header.i=@web.de header.b="foean23M"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730796AbfFTJpt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Jun 2019 05:45:49 -0400
Received: from mout.web.de ([212.227.17.11]:34763 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726294AbfFTJps (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jun 2019 05:45:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1561023940;
        bh=hEgF6OSeCfwgBif/kxdT6Z+l79AXOO5Gwuztx+BfNcw=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date;
        b=foean23M2wtdaGOIMwJbLbJ0e2TsrUbcKiPLHoUst260UJ0Ijk532RMvuw/YLhFDq
         qHcVeJBFJTVYDZ3iiBruqDRxPGEginVjZ71BdI3JJTkRqcj/cX5R2bW4QlvLZN5bqs
         JZ9+C5dk3w565NKgrPvwhv26k5u4Yh1kAZBUxYgs=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from lab-pc08.sra.uni-hannover.de ([130.75.33.87]) by smtp.web.de
 (mrweb102 [213.165.67.124]) with ESMTPSA (Nemesis) id
 0LwqFo-1ifmo83IeO-016Syv; Thu, 20 Jun 2019 11:45:40 +0200
From:   =?UTF-8?q?Christian=20M=C3=BCller?= <muellerch-privat@web.de>
To:     gregkh@linuxfoundation.org
Cc:     johnfwhitmore@gmail.com, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org, linux-kernel@i4.cs.fau.de,
        felix.trommer@hotmail.de,
        =?UTF-8?q?Christian=20M=C3=BCller?= <muellerch-privat@web.de>
Subject: [PATCH 0/1] drivers/staging/rtl8192u: adjust block comments
Date:   Thu, 20 Jun 2019 11:45:33 +0200
Message-Id: <20190620094534.5658-1-muellerch-privat@web.de>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:ejcM29jC0f397KB0zritUwbUYZZ89Uw6vwc1O+Xu9SWjgFvfuPC
 b2Jld7+MtjW3CqcdWVl02TKsYveKQcles2sEytlmrJsBbcpemsdSCWXkXd8nc6FleKFPCYq
 ukeU+c9Xc+8LLdC5iQoYvQBaFRTr9/ttDWBPlBOAXJu19KfNwmtSL3P/1RrL1FWToPr9VV1
 1L+xJ2LYSoAaBVdMXxLjQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:XGLcXQsgQJE=:YlRQM1WWjLg1bXWLt5qt+K
 dM+QpJSDpBDksBmXqPiUncYt0eoqjrFBIemNp1OhBJh+TmrC9+Rd8IpEmwN72eU4HacwgFw2G
 IUZEjd57BeUwSQvcwA8fHwe6OKyAAPqePXgaaPl0SNC/a/FGa9Tp5QdOZqtNKgfWso8nJtwAa
 zfp3A/WnARELWKvr5+C6Vd3rrr8sHfM0sCE6GjBH07tn0ad3FHzqGgJpDrJzCscmRc/O+SbzB
 Z8HAuShzGQN9XSEjdqdMTnctDHdgHhhM93EcpB72NpC4yrZm2iBS5D6m3lyxHoYODqbzsbRFS
 6giYVVpWu5iITaTjL8saoIORQ7zAGCLVtnEqf91nnG/yBFWDcsuOx/UjX9qL11RdTqICQy0Q5
 DlCSpZZqTkU/aPYijKWn1Xf9sPx2oCIz5bO1E/fTJaMaR4kAderqOwJDnaGmxfFumRSRBa6t6
 8DV9tCOQEljkgAWLfqh6yatBDGKKqy/MJMNXjON+RHFYp6XCRCIthbRlxviR70P4mWzbMY0II
 peM1xjHZqQyDoA4lv1pcD1WuyZpV36POaJC+V3V+PRr3RCIsOzMecyG5tRa2N/II+Rq7nwFMD
 6QGrQ3fvsHrnLIfcvL8MaNzJ6nrMyXBzHC1E+YOyJN2i/fJVRsfDZwFyNTQhBD6njFPZZf75i
 fzeVDhCxQxYIBMwjlHFuVY5iOHpQzfS8RuHjSYFSK1SkFxas85xV9w4vEg+D45dr51XDCllBh
 8j/1Wfi6heHAwPcPXuQD0B+2nmT9Uk9YvOePW0pAE2R4/CW4KKDuEZOgC/tTa/keYbqIQbrbV
 1r8EJiYW9X0eHgDRq/JpMpQK1Bos+YkVwSNfNwt475MWSdDgy9yyvVqi4yuI8ggibNeN4VSMj
 GJj4YCVp6vBzSlR7fu5Jw/7+ifQX6r/1Re5FintURiwMEBF3YJkkHYWO3heIQIqITZ0ehiPIj
 HZjwMdHZ0k7+Y6owSczirwBjGFzkagwNPTSRWDJ15hDkl1QeUUom2
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since our last attempt of a few enormous commits, we ditched our changes
and started over again, this time with a lot smaller changes per patch
adressing one small thing at a time.

Sorry for the inconvenience last time!

Christian M=C3=BCller (1):
  drivers/staging/rtl8129u: adjust block comments

 drivers/staging/rtl8192u/r819xU_phy.c | 39 ++++++++++++++++++---------
 1 file changed, 26 insertions(+), 13 deletions(-)

=2D-
2.17.1

