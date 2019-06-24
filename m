Return-Path: <SRS0=hO5d=UX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F364DC43613
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Jun 2019 09:47:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C7ED12054F
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Jun 2019 09:47:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=web.de header.i=@web.de header.b="pHGrb80a"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728482AbfFXJrH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Jun 2019 05:47:07 -0400
Received: from mout.web.de ([212.227.17.12]:57333 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726481AbfFXJrH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jun 2019 05:47:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1561369619;
        bh=lzyy9j7qnXqsvAbV76zCce0wMX+0BQGE8HteHYxHRGQ=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date:In-Reply-To:References;
        b=pHGrb80awqEoTQ2WTdj5YtnMWnHcsYlKURR2Cek0xB5oEyxkYKDlfWB5lGrdqjyk1
         PkbMK7YAWTOA8M3iPrdCtevPsaL4cLUUYRjkDenNhCXuCPKsvR6iXuF9maBZd2CG1w
         vFJW4R/afwfNlrj40WWLWJrfoj4jMBo9a53QSGFQ=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from lab-pc08.sra.uni-hannover.de ([130.75.33.87]) by smtp.web.de
 (mrweb101 [213.165.67.124]) with ESMTPSA (Nemesis) id
 0MUFGo-1i6OuH3DHe-00R3Wg; Mon, 24 Jun 2019 11:46:59 +0200
From:   =?UTF-8?q?Christian=20M=C3=BCller?= <muellerch-privat@web.de>
To:     gregkh@linuxfoundation.org
Cc:     johnfwhitmore@gmail.com, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org, linux-kernel@i4.cs.fau.de,
        felix.trommer@hotmail.de,
        =?UTF-8?q?Christian=20M=C3=BCller?= <muellerch-privat@web.de>
Subject: [PATCH 0/2] drivers/staging/rtl8192u: adjust block comments
Date:   Mon, 24 Jun 2019 11:46:38 +0200
Message-Id: <20190624094640.5459-1-muellerch-privat@web.de>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190620113308.GA16195@kroah.com>
References: <20190620113308.GA16195@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:LbTnXBDz6pMGBFVKewlRvSH5QnM8/tq+wHSt2/fIhFXqTGjGumT
 hcEoDIJ/cUliTFC38xixU44E5siemKomEAarNnQQH8WZDQDeNgBjn95NYnB9LYEMuXco68R
 K44qIjV1dXESxbDPVUOI8/fcmP18nLynFNnBYqPAouIbWexQ4peptEqAa0mWyIFXScimQnt
 U4yJ0OCZvSWdXEeu8GvEg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:wvBOKAObEwQ=:l2pNXkW07JEiXA+GGYOcLa
 R1fvRyb2YOKIp/HUB5y0tQUm8x8MCoa46vGkpEVZU9j4FXU1KfqCSfF+deR2SLhi3USy9BSLh
 0iyK02bl4LVCOHbP43qJMUCU4HGldYm5aneEuRxC1yXQw2KdukAuDx+DEXII95+DBxb5IKf0p
 oLf7q5bsG7G2dsSgI2x9wxm7TPOr2xPKarMxpkYJmZwc8kdfPZvRp41bKTSIO5K+++utbAWP6
 LN2eE9cXOwR6dr5r243wkI2oTnlDfBIy+qKRoUU50yms+KYTMYf0XWJMXcIniP+yQSvjy5tsv
 euwOw8EP58dZZjo20OovcN+yCV3hMVgU/mBMwergJw20s5MwjlXrVtq39bNXs5p6hka6sSIRz
 tiHaL58V0Khm2d8H1dtMBgXsGdQhvyRq2KEIxeK7WPNODdshxz3bKK/dW4dHIWG75pML/6Ux9
 i72ajG5h7LNIy0G124q0ivO+t9Nz6Ts2ZLG1BEY+MlW4PuDEQyvCLIrYF8gHRnoo1U5YhQbH5
 cl46ITxxxlBuO7fRhmDIIU+ypIYEKIAJ9KPtrg/VwVGTojnHkskyhTy4K9KPweihz4E6+ehV6
 yhwvvoxVb0buaF9RB6RTvNwhfiw0ZTq+pcRMF8+R5DLs50Dy03R98np4Ma2gPEfGMUsRhoTE4
 MXxlLcD/rKrxBqOmEbh+cHHlqXEYbPS9Eyms31D+2im7kmIEm6Dq+1f6zlI6ug8Y+cRv3Vk87
 U1hsBYEyNl8JSWc/22Mi9p24GXfOV135W8pMjGMS8rD6DdMG/g+CbGMyWMAnrj3Rrazn/ZHur
 5BR3jJSNwjIcz9+OEVTmS6bMoB2sLN/4SlM30Hlz6yZvlvvPgiDicf7i8Zt8fV3iFZsfYtITF
 JZbMl2jkaXtk+QFo6hUthcMO1c5mnFu8VHPGskhal5b3sj/nRDJhE5Etb/xNZOd0t6ptK2dAT
 FKaDbPZ/rr91wakaz2DuZIZdhxKdcGIfZIoLqQMPaRxlRFFEa0V41
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As per the last correspondence with Greg, he pointed out that the whole
driver rtl8192u should be merged some day into drivers/net/ and thus
implement different standards regarding multiline comments.
Because of that, we did the exact opposite of what we did the last time,
and changed comments such that they obey these standards.

All multiline-comments in this file now look like the following example:

/* Multiline comments
 * in r8192U_dm.c
 * now look like this.
 */

Christian M=C3=BCller (2):
  drivers/staging/rtl8192u: adjust block comments
  drivers/staging/rtl8192u: adjust block comments

 drivers/staging/rtl8192u/r8192U_dm.c | 97 +++++++++++-----------------
 1 file changed, 39 insertions(+), 58 deletions(-)

=2D-
2.17.1

