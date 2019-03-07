Return-Path: <SRS0=uyI7=RK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22FA7C43381
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Mar 2019 01:50:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E091B20675
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Mar 2019 01:50:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726676AbfCGBuX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Mar 2019 20:50:23 -0500
Received: from mout.kundenserver.de ([212.227.126.187]:54307 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726260AbfCGBuX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Mar 2019 20:50:23 -0500
Received: from orion.localdomain ([95.118.27.116]) by mrelayeu.kundenserver.de
 (mreue012 [212.227.15.167]) with ESMTPSA (Nemesis) id
 1MBBCI-1hEKAM3E8U-00CkQ6; Thu, 07 Mar 2019 02:50:20 +0100
From:   "Enrico Weigelt, metux IT consult" <info@metux.net>
To:     linux-kernel@vger.kernel.org
Cc:     dmitry.torokhov@gmail.com, linux-input@vger.kernel.org
Subject: [PATCH v2] drivers: input: Kconfig: pedantic formatting
Date:   Thu,  7 Mar 2019 02:50:11 +0100
Message-Id: <1551923412-7174-1-git-send-email-info@metux.net>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1551898105-17927-1-git-send-email-info@metux.net>
References: <1551898105-17927-1-git-send-email-info@metux.net>
X-Provags-ID: V03:K1:w2Up3HI0CyXUFTJ/izi9tefROS5j3QE3SbQ57Ep7kIwHC0W+K30
 YJ43yBgxyvnkcksz/OjPwF/TcuerZR+mJ8ZPUcLnwdj4QD70E0VeEcgR5YI4z6mdBPZFCve
 O5kcNFICWBLbxsAuIilhPTm1AELg78n87qax2Lq0i30aLu1yxECnJZbcQNRGZNZNc59PWZE
 v4+tcgqKtwaIZDUeKdilQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:AGi0qtv1fQE=:539+6sdAJzPWUUa1Rgz49p
 BGmcFCjLO3FWS4Vumxl9xSxD7lMUGaSSDkfiewJwZ1J1uJi2F/y8xJoDOc5csNnxdH5vSXs/r
 ep50wOdgKlkm3Y0vadyC6/uokyjv07ySsxq9EMHIC6nxAX0xadKbvTlDFtNL1R38oRcNf80Fz
 6cQpLyRPyFbHn+L2MXxmslbLdkX0DOMN9j1+pdvCmV7C283OAxmQLq73AQfrW/bfbFrjr2N1U
 3D8QE5rLuOTefR4f3OKCsqRYf/4X+Lx1QOVlADQFAPtuyTiqN/qp8FlmUL+I52CxwrEN69U7n
 E9K9p4b/Ya+RfDD8SyPZTO6J+L9BCMOQIOCzYOINWpnJXd80H8CoFmnhDMM6HNXpeJiviFGN8
 fpOn7SDd58RDdMnB5iHQxzRZtDn7WoUwWWRZTT4FDhQTxZfciRUswgX2pgiHbFF9Bwg39gu46
 HbZaAt4EkkrSf7qEHAsQcAFMWf5f4y92yFw2CvRABC+o42FbNMZrIgj4gLTN9GWGlakWD0HJt
 FxH0H6Xi++of+vUin3WTF7A6YoL5bPRhCo8pH0CE31SYAFGKGmA9fGsSDwhrTs8FoO0qZQSar
 wl40czjkFuSYR1FsFTrGZqyILfNd1gm+KzUtRpO3ewXpA2mvtcFjgjDiK3xbAIeu1w4uFpaL+
 +i1z0Zn1zNhQIIbETBR40gJ1JN2rpfKEAYWaElEXlpvaaJosMDYZY0QjPAVi+ndV+kqXztQob
 NtxBTSKfmfp48iEZTjDoTmNUU+F7GX3benOnEg==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

changes v2:
    - squashed the patches into one
    - fixed patch description

--mtx
