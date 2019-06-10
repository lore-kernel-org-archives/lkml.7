Return-Path: <SRS0=f7FU=UJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69124C636CF
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Jun 2019 14:25:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3DC8220859
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Jun 2019 14:25:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="jhPIwgyZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403901AbfFJOZx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Jun 2019 10:25:53 -0400
Received: from mout.gmx.net ([212.227.15.19]:51201 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2403856AbfFJOZv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jun 2019 10:25:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1560176742;
        bh=U44tvgLFlGaanEXUft8L0ra5RPYPwCR8fVvFRN9rId0=;
        h=X-UI-Sender-Class:Date:From:To:Subject;
        b=jhPIwgyZDrcYiBE+EBVITpjmvPs8k9ybFnBqORDaxjODcpAt37tHB6PfgUKF0NCCb
         DWtjsoQEsXz93E+sAXRMVK0jGkQ1UcV2K45xvSwaqRdZ+xh+i8cY47FtkfzCAK/KyI
         mGp+4SMoCWEj61fxRNs3x6hUdm/HJCQl8c9cXj5c=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from baum ([188.192.86.147]) by mail.gmx.com (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1N3siA-1gamQQ0aDg-00zrCT; Mon, 10
 Jun 2019 16:25:42 +0200
Date:   Mon, 10 Jun 2019 16:30:26 +0200
From:   Li Mingshuo <linuxli@gmx.de>
To:     Larry Finger <Larry.Finger@lwfinger.net>,
        Florian Schilhabel <florian.c.schilhabel@googlemail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Subject: [PATCH] staging: rtl8712: remove the leading spaces
Message-ID: <20190610143024.GA6154@baum>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Provags-ID: V03:K1:5EtO3LE+QSuVCzAbJwqSNCufpBC2Aw1MmQ7nY0FBtBEGaeD6eeE
 GzWcSLsYFO5hgsc3foTkbP4WUF/moYt8MCT75YxmSB+RY8YY5GxsPP0f+vlkK763J/SSYEX
 qGTMU5lpLf27wlpWcfNuD7TB0FjYgDHdiD3brcjnDoIJTX0ou7UOIwDWbCNPJ6XTa6NFvwJ
 Ry4VQt9y4dG8WozhKP4tA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:1nwd2riEFaY=:H9YGwNcLOMEljwutjRS/5e
 rstzuPeNjjJKws6LSo5xKkaCGN0ASct7o9aGbSKMMmdKzpWleoO9tJyuaOGMhh5UFoEgoupnk
 lkHCAMJ0ZT1hHRSmMeVyxiV1UY55amaKRuQ8OmHTTsFNwnasfhvWkuVluifFguUxmPFUrQARt
 P5OJqg2nIFFkqMz6wtC/acQNGvPQdrnryvfFf5lYBfD5tDRdt8G+ETXo6UhxHduCkKiau12Xq
 wjofvbJo4wNyfT5NkZLgZPAXnsEfwX+FrtQluu//r5oPZIlGJClPI23mEOGj10wYfB6wu9/Ni
 Z2JXfQZujesZNqRY9tSq3ocgzDPBMSOYRprqXpwnEgAqthBMpGoGzrohBUJ/DFk8WOJh6M+iE
 CAqScJhJVn6NbYmR3iu5wgiOjaCmiLXwetB1F5VKY1jcwoqAK0+o9mjrvaM7+l5qNHm2E9U67
 nhORmubxQZhzRegBc1hp7vF+8uR4/pEX1YjeUNyMB9MqT9c11U0Y2XvbrduT0joPD1VDRjFC+
 PIhvw/pHDrxt5NQxnKKq0pL7Ptn0P1/OCfcrbvnOriXjI4yAQORa+FIreNGbWLrjl2afmLQVB
 C5V2AdsP6azJ2cESHHnE+jwf1F6iBiytTF3ghFiQArOq0p6jk+xpI8moWw/y7Ps5LNqwAbEwj
 7TuMGiKna35CLT4aIvW0+4ZvI7Kl/FwRNCoxAkmDM4P+Zz9tn1/POEHkulQl8Azh4rMi11r1V
 KktbpTfULV45/EVLOvERiBt5V4YbOE5lpBHBOHqbJr36RRXOwSIQyaiYAXhwbz1H0X2JdcyyG
 B49RRe81gct9w5FUYx3BF2Q+FKjuymqafsMf4/CaZRIZ+XUytvNZtXFsnXpib86+MPnk+vv/e
 vtEcBPpG5k51FUxdea6n5gJbZvf7f1DTq4r+EoeApRPui1BqkM5bPECJCbPu0LYUmijmKxllP
 jzAhqWPWAJXKgpuW/T3IQHQIDUlyG21I=
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch fixes the checkpatch warning, removing leading spaces to make
sure that tabstop starts a new line.

Signed-off-by: Li Mingshuo <linuxli@gmx.de>
=2D--
 drivers/staging/rtl8712/rtl871x_xmit.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/rtl8712/rtl871x_xmit.h b/drivers/staging/rtl8=
712/rtl871x_xmit.h
index 3bea2e374f13..4199cb586fb1 100644
=2D-- a/drivers/staging/rtl8712/rtl871x_xmit.h
+++ b/drivers/staging/rtl8712/rtl871x_xmit.h
@@ -148,8 +148,8 @@ struct xmit_frame {
 	_pkt *pkt;
 	int frame_tag;
 	struct _adapter *padapter;
-	 u8 *buf_addr;
-	 struct xmit_buf *pxmitbuf;
+	u8 *buf_addr;
+	struct xmit_buf *pxmitbuf;
 	u8 *mem_addr;
 	u16 sz[8];
 	struct urb *pxmit_urb[8];
=2D-
2.21.0

