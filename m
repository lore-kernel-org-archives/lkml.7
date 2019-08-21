Return-Path: <SRS0=xaRW=WR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81A69C3A59E
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Aug 2019 14:35:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4F3F6216F4
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Aug 2019 14:35:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=brennan.io header.i=stephen@brennan.io header.b="n9LjiHkZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729393AbfHUOf4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 21 Aug 2019 10:35:56 -0400
Received: from sender4-of-o55.zoho.com ([136.143.188.55]:21580 "EHLO
        sender4-of-o55.zoho.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728763AbfHUOfz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Aug 2019 10:35:55 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1566398145; cv=none; 
        d=zoho.com; s=zohoarc; 
        b=VNRKugRJEyO5IqDtKrg6+UjxGs+9vxF6KJPUpO6H56xmqO+ibGwIfd0Xi9LXMHdrtG5hx2STjUqcdyO6/H5FXmScr2i4x1JfeQw4HD+hOIvEMrMIK83GRkEuYlVnTfOLSfIUVcAoyQ+ewAy65M+4WZ5P6WwxRpMT9P7H/n3fD9o=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zoho.com; s=zohoarc; 
        t=1566398145; h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:MIME-Version:Message-ID:Subject:To:ARC-Authentication-Results; 
        bh=f22V/qNVlYw5I4WKBZDrjRWbTvWAuj4evwp6Q6Y8Qa8=; 
        b=FUHcyRQhIEIOsLbFnGW6WKa6PcIX1BGuBwMZ4i30erG7QPdYrl7ytjc7J9AN2nV5XvFaGDIgSgavlwBFdTe7JoGbdwNiKuBxdcz3QnnTuhMbymIgRsSwgQFWW8+YCS5YaS9TuPMweXgb5Vstp3seowh5PKWY/vi84nGM1CQzz2E=
ARC-Authentication-Results: i=1; mx.zoho.com;
        dkim=pass  header.i=brennan.io;
        spf=pass  smtp.mailfrom=stephen@brennan.io;
        dmarc=pass header.from=<stephen@brennan.io> header.from=<stephen@brennan.io>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1566398145;
        s=selector01; d=brennan.io; i=stephen@brennan.io;
        h=From:To:Cc:Message-ID:Subject:Date:MIME-Version:Content-Transfer-Encoding:Content-Type;
        l=1232; bh=f22V/qNVlYw5I4WKBZDrjRWbTvWAuj4evwp6Q6Y8Qa8=;
        b=n9LjiHkZc8f04AI3V+jiVd5f8coz/EHRnvw0jwlOvEhtg8Aou2/szd4VkKigg//m
        FHKhuxIfrS8kjO6DHIhLgZK5ccWM8A1+1Vg0eGRn5qyg+9ZPoR51KOvzbqqZ27vfYCj
        zjR/5lJziYHdxbVMS5RNE5Ja3hPzbl0WE/8blpmo=
Received: from localhost (67.218.105.90 [67.218.105.90]) by mx.zohomail.com
        with SMTPS id 1566398144866732.0878686594964; Wed, 21 Aug 2019 07:35:44 -0700 (PDT)
From:   Stephen Brennan <stephen@brennan.io>
To:     "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>
Cc:     Stephen Brennan <stephen@brennan.io>, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org, "Tobin C . Harding" <me@tobin.cc>
Message-ID: <20190821143540.4501-1-stephen@brennan.io>
Subject: [PATCH v2 0/3] staging: rtl8192u: coding style fixes in ieee80211
Date:   Wed, 21 Aug 2019 07:35:37 -0700
X-Mailer: git-send-email 2.22.0
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-ZohoMailClient: External
Content-Type: text/plain; charset=utf8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Addressed some spacing, brace placement, and macro alignment in this
driver. I do not have the relevant hardware, but I verified that the
drivers/staging/rtl8192u module built between each patch. This time I've
included proper patch descriptions, my apologies for the previous series.

Stephen Brennan (3):
  staging: rtl8192u: fix OPEN_BRACE errors in ieee80211
  staging: rtl8192u: fix macro alignment in ieee80211
  staging: rtl8192u: fix spacing in ieee80211

 drivers/staging/rtl8192u/ieee80211/dot11d.c   |  10 +-
 .../staging/rtl8192u/ieee80211/ieee80211.h    |  38 +++---
 .../rtl8192u/ieee80211/ieee80211_crypt.c      |   2 +-
 .../rtl8192u/ieee80211/ieee80211_crypt_tkip.c |  22 ++--
 .../rtl8192u/ieee80211/ieee80211_crypt_wep.c  |   4 +-
 .../staging/rtl8192u/ieee80211/ieee80211_rx.c | 118 ++++++-----------
 .../rtl8192u/ieee80211/ieee80211_softmac_wx.c |  14 +-
 .../staging/rtl8192u/ieee80211/ieee80211_tx.c | 121 ++++++++----------
 .../staging/rtl8192u/ieee80211/ieee80211_wx.c |  35 +++--
 .../rtl8192u/ieee80211/rtl819x_BAProc.c       |  12 +-
 .../staging/rtl8192u/ieee80211/rtl819x_HT.h   |  17 ++-
 .../rtl8192u/ieee80211/rtl819x_TSProc.c       |  14 +-
 12 files changed, 174 insertions(+), 233 deletions(-)

--=20
2.22.0



