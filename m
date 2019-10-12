Return-Path: <SRS0=7jSw=YF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02551C10F14
	for <linux-kernel@archiver.kernel.org>; Sat, 12 Oct 2019 17:12:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CD6BB21850
	for <linux-kernel@archiver.kernel.org>; Sat, 12 Oct 2019 17:12:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="M2F1gZ0b"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729546AbfJLRMC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 12 Oct 2019 13:12:02 -0400
Received: from mout.gmx.net ([212.227.15.18]:37783 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727262AbfJLRMC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Oct 2019 13:12:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1570900308;
        bh=zaIHlElwJeVfh0jWDyK+4rZg0MDOriNjT4iHsnl6zlw=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date:In-Reply-To:References;
        b=M2F1gZ0b0f7/tXChV2SYF/DZvKIFg42d13WuLgtXoY5k4MPc5O5U0PDCrRz1LlaqD
         tBcNtyCk9dpbIRVJ1FOK1a6r3hLtnStAHh0eA3RZ855dtGYbzKv45SBbDpXxc9A9Gw
         sPzr9rISRZHVXP0YagSr+XB1ycBS/XVfFHEBfquo=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from longitude ([213.196.244.109]) by mail.gmx.com (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MbivM-1hn1aP3Xbi-00dEkd; Sat, 12
 Oct 2019 19:11:47 +0200
From:   =?UTF-8?q?Jonathan=20Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>
To:     linux-doc@vger.kernel.org
Cc:     =?UTF-8?q?Jonathan=20Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>,
        Jonathan Corbet <corbet@lwn.net>,
        Cornelia Huck <cohuck@redhat.com>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Logan Gunthorpe <logang@deltatee.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 3/4] docs: admin-guide: dell_rbu: Rework the title
Date:   Sat, 12 Oct 2019 19:11:11 +0200
Message-Id: <20191012171114.6589-3-j.neuschaefer@gmx.net>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191012171114.6589-1-j.neuschaefer@gmx.net>
References: <20191012171114.6589-1-j.neuschaefer@gmx.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: base64
X-Provags-ID: V03:K1:HtUxZRlpo1IMjjHQOB6u4NDcWDuukfE+RC64LJn27TbX04MaEuV
 ohEmxOY4Bk7KIqXd9OhKm8V4t/gf62wJNRASTMSjFJ6d+wvUw+eON2A8+DBSc13znnXTutm
 78w3ialLBEAPENSICGCu5GrWbeu3BCOOhenZAMI5Tbg0msHk+PBAb2iytaxT3lW5maLsnxW
 ljGgg4Tgb6shChfSWcVuw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:rPnMe25S1eA=:ijMZ14W69PXe6CAAn0L656
 LSqwEmisP1963ZSoWuoL8Ce5b/nm/5tGch8pULCtNFMEqJq1YpFbiiC/XU7FxpxUy2/l5RgNk
 P8/kPBhrx81khJFCq12+sl5WbycoZyEt0oa0ousuKXKH7B7YPMD8MVZFSQvdH08ViuchTcvpq
 3B3/Ea/sFj8HvD7jcosXNBMNifi4OFaKAXdH6ozZ7NI6CRKhsDNpbEBwEPS7L9ADkb9qJkbP4
 XPEX7elK8WKIHQncq01o1g8/O144EWITQXPo5tv16B0AhJ0NRVSAb/mW8hKwbi5OOQzpzzc63
 ijdsapiRSD1uFbvBLvbK5rZkT5g/9Be60Wr3FS4K3UlhYfZGj/oRekpPpnAJb/of4pxdyxooK
 3r26/evEtwFan2j87lGz+q8DF2fP8u0l5cLspGErNFC3pa5XntSpKlZfMHaC7dXQe2qcMWfe4
 DDYdAzUS9Hruvr3SVxSS1ASeqEj9p+z+pJ8wR+6QUbgUEqT4OExtYNmkhZz/kmqYMV91wZOUY
 lY7h48GuCfXZ8doKy1pPuenOFiCBNkepJklYGmB3zeqWnVr+H5SjF8/3tiGlVn1zc62uLM0uw
 rwYlvj+qCW7zV6mOTMmJUwHZTCo80mr4k11Y8pYux1iSjaFogHz3SiXWJl8N/uhbZ4qDLuSuV
 RZ3Mmp5BFijNWzTn483GX/OIAMe0G4hONQCJNWL2KRKOPozpyhvKIkcjpNw/o8Dvf+crWIDau
 sZaAxcKAnvq+Eg1u/i6HhOFA17WWHTWefFs71vhFwZShNFT5boYLn2X3vx2m9e9NVOZh9pAs6
 taie05vsNR51s15AM71owhS2LVTQ49InNeFRG3KGwQERzyhX9ccofkbwpAHYp3JQ+pnFojGq1
 tczBqnrea4ofEOWLaRs3oeCuPYaSHNUz1LO7wdL5myA4s1R+mswwO66J9oCe2omyAVe/w/Hhq
 8R7kEFAaamgT9M6tjsMcwTLiPHYCvAtRdOsh02tieuK96LJTVHmB8LlBA7f71mzzDS/0IAw16
 bNSLx7y1oCegJ6eiaWbWIfDTw4xd4mzcJ336qvU2Vl9JPBQ4n2sux9z+L4cCS18MbWZD691W0
 K43DSANzQlzOKktFqXdqDTrPscsWrdG1tqj7nEKinpjfQAPJksuhXhbd0LBGGXIP+P+lkPTqX
 TEOQTDoL6RrBxur0u9rrw4uZj0Uq/LzrH0vuC5NWo1KaLScxNev15NzZYgB3whWyz10QTzMvd
 jPkV23rYwN+hIsF0FG1wpWLKg9HKG3PM1p+CeWNIoojSfAL5SoY7s1iB6L8c=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

LSBNZW50aW9uIHRoZSBkcml2ZXIgbmFtZSwgd2hpY2ggaXMgYWxzbyB1c2VkIGluIHN5c2ZzIChk
ZWxsX3JidSkNCi0gUmV3cml0ZSB0aGUgdGl0bGUgdG8gYmUgbW9yZSBjb25jaXNlDQoNClNpZ25l
ZC1vZmYtYnk6IEpvbmF0aGFuIE5ldXNjaMOkZmVyIDxqLm5ldXNjaGFlZmVyQGdteC5uZXQ+DQot
LS0NCiBEb2N1bWVudGF0aW9uL2FkbWluLWd1aWRlL2RlbGxfcmJ1LnJzdCB8IDYgKysrLS0tDQog
MSBmaWxlIGNoYW5nZWQsIDMgaW5zZXJ0aW9ucygrKSwgMyBkZWxldGlvbnMoLSkNCg0KZGlmZiAt
LWdpdCBhL0RvY3VtZW50YXRpb24vYWRtaW4tZ3VpZGUvZGVsbF9yYnUucnN0IGIvRG9jdW1lbnRh
dGlvbi9hZG1pbi1ndWlkZS9kZWxsX3JidS5yc3QNCmluZGV4IDVkMWNlN2JjZDA0ZC4uMTA4MzBk
YjllNjE2IDEwMDY0NA0KLS0tIGEvRG9jdW1lbnRhdGlvbi9hZG1pbi1ndWlkZS9kZWxsX3JidS5y
c3QNCisrKyBiL0RvY3VtZW50YXRpb24vYWRtaW4tZ3VpZGUvZGVsbF9yYnUucnN0DQpAQCAtMSw2
ICsxLDYgQEANCi09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09DQotVXNhZ2Ugb2YgdGhlIG5ldyBvcGVuIHNvdXJjZWQgcmJ1IChSZW1v
dGUgQklPUyBVcGRhdGUpIGRyaXZlcg0KLT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT0NCis9PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PQ0KK0RlbGwgUmVtb3RlIEJJT1MgVXBkYXRlIGRyaXZlciAoZGVsbF9y
YnUpDQorPT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT0NCiANCiBQdXJw
b3NlDQogPT09PT09PQ0KLS0gDQoyLjIwLjENCg0K
