Return-Path: <SRS0=KwB+=SC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB54FC43381
	for <linux-kernel@archiver.kernel.org>; Sun, 31 Mar 2019 22:35:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 75AEA20866
	for <linux-kernel@archiver.kernel.org>; Sun, 31 Mar 2019 22:35:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="PaXDlKly"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731553AbfCaWes (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 31 Mar 2019 18:34:48 -0400
Received: from mout.gmx.net ([212.227.17.20]:47471 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731172AbfCaWer (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 31 Mar 2019 18:34:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1554071670;
        bh=AOZTrA/Ra1bCUHk9C5awQmJrazYS0r5o29tb8AngkvQ=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date;
        b=PaXDlKlyeLww7YJ6fouk2QhWOp+KQwRYnEZAp+ZbC7G4c+DF27pzBxlUvwRSZzE2K
         hh0F0Vsv85L0SUYUlZ7WG9m7eb8ygrbFcEsJYqWOlIh42614mV40lzUbmUAiIPtYpI
         B0zQpZXGyHZS3zFieOU69IcgcEu9WQKve2V4CQNY=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from longitude ([109.90.232.48]) by mail.gmx.com (mrgmx103
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0M6B6s-1h0NBM2lbu-00y8Dv; Mon, 01
 Apr 2019 00:34:30 +0200
From:   =?UTF-8?q?Jonathan=20Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>
To:     linux-doc@vger.kernel.org
Cc:     =?UTF-8?q?Jonathan=20Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>,
        Vinod Koul <vkoul@kernel.org>,
        Sanyog Kale <sanyog.r.kale@intel.com>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Jonathan Corbet <corbet@lwn.net>, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] Documentation: soundwire: Ensure that code is inside the code blocks
Date:   Mon,  1 Apr 2019 00:34:22 +0200
Message-Id: <20190331223423.29855-1-j.neuschaefer@gmx.net>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:AveavH69cVp1MMTdK81kxQBsjNX1ivILo0rksVwpODdcZeL+vOh
 0sX0n0XNpur9NK8JOqDTWbtQdK3/tlB2fzJd5jwWs1kZA3PmBDICYNtj5/v5M63Y0e0lGyV
 +oR9dKaetOHUSpn27LzklaJsP9cZdhjBXxo8/8Mtw4frZVypGvnaQ1ww/E/mlCAJDel173h
 paBRAFKuo0PAtnO2TNzzw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:ML9JIszmFd0=:MP7NUANoU0o94iYSueA1CY
 JQMtAZ0ekovN7jg0FdV1AvKve10mLbBcl1cZrw8x/2nilixJc3yhmo5ctFCfZYULRjSTet6h4
 0gBlfsfiVKPE+nRVCd5u7QkhGVojck6wID4jE34I3lKio5cB3WF3zrtPMhdHk8rK9TLyzCsup
 hAUNa/PG7zSAalYxMDwmNLdR+WcaJ7W4/QhpUwP89RduYGEn7+sEM84pssGfzTj4rkSZVN5L0
 4g/i81/abGmBsnVx98rA6jwTP2gawGv823jzqf6CQjzcWpUPkLljPQeVXb+VvFNOQcmH3VBrT
 D2EPJLvl2MyzuLoCLglOfPOA/E6Lxbkb7k+j9ar2nms7PynIUwd99DDTQGN5Nr7w0dqe1Zrqt
 BQknvLjtf4+tqWQ47GKfiUUQi5+yZwVRfxSfX2KSDlZlmDYXp1UB6bKo2q6EMw2giPsoPHRUf
 T7wM5OC2TFX9AeVRWlPp2nRClRHcewtdTHjh61lGOqA4I39+g1E/U2HYn37K+jbuqKV0ShsTE
 iuEaABIKo0Mgw/ePaSAuE/eWrAT1I3iOvq7Y09+1bzE9ZV4iy65TA1k8CI5sWH4jYCiROD4ol
 l3IbvIZ/Ua484ZmP+tjmmRW+2slk9+8YOVNq8G24dcn2YQB4aoEunh9eG6kuo+O2yG7ighMIe
 I0sTeokS7c6A3BwijXGQY2b+NFzFAeN+jKnP5VxvjM7Me6dCXB8n0KPVQ9PmhrjwCyrQ7f42v
 6UrYZI7CQUnyKN0NCKs7VFpsBgx6m/+i9SJxrbLqYeWQrm/zujm4Ie1GPYT1Q73nE0v1lO1Vg
 Om0/GUpxN/o7gaklebQkccKiuxsDrx/jyD0tR1z1fE0RsLBdY/F/mwNM4a6NeJN7HGNxr/eDP
 RmL13GWGBGdehilHjV4EO4QEagaqA/Xm2A1+i0rGYlz9xKpNxoV+rjPEE8N03/LSiRxyWOe43
 rgj28bL3Ulw==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The way the document is written now, Sphinx renders empty code blocks
followed by the lines that should be inside them.

Unindent the code-block directives to fix this.

Fixes: 502c00d9c315 ("Documentation: soundwire: fix stream.rst markup warn=
ings")
Signed-off-by: Jonathan Neusch=C3=A4fer <j.neuschaefer@gmx.net>
=2D--
 Documentation/driver-api/soundwire/stream.rst | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/Documentation/driver-api/soundwire/stream.rst b/Documentation=
/driver-api/soundwire/stream.rst
index 26a6064503fd..5351bd2f34a8 100644
=2D-- a/Documentation/driver-api/soundwire/stream.rst
+++ b/Documentation/driver-api/soundwire/stream.rst
@@ -201,7 +201,7 @@ Bus implements below API for allocate a stream which n=
eeds to be called once
 per stream. From ASoC DPCM framework, this stream state maybe linked to
 .startup() operation.

-  .. code-block:: c
+.. code-block:: c

   int sdw_alloc_stream(char * stream_name);

@@ -228,7 +228,7 @@ the respective Master(s) and Slave(s) associated with =
stream. These APIs can
 only be invoked once by respective Master(s) and Slave(s). From ASoC DPCM
 framework, this stream state is linked to .hw_params() operation.

-  .. code-block:: c
+.. code-block:: c

   int sdw_stream_add_master(struct sdw_bus * bus,
 		struct sdw_stream_config * stream_config,
@@ -274,7 +274,7 @@ Bus implements below API for PREPARE state which needs=
 to be called once per
 stream. From ASoC DPCM framework, this stream state is linked to
 .prepare() operation.

-  .. code-block:: c
+.. code-block:: c

   int sdw_prepare_stream(struct sdw_stream_runtime * stream);

@@ -304,7 +304,7 @@ Bus implements below API for ENABLE state which needs =
to be called once per
 stream. From ASoC DPCM framework, this stream state is linked to
 .trigger() start operation.

-  .. code-block:: c
+.. code-block:: c

   int sdw_enable_stream(struct sdw_stream_runtime * stream);

@@ -332,7 +332,7 @@ Bus implements below API for DISABLED state which need=
s to be called once
 per stream. From ASoC DPCM framework, this stream state is linked to
 .trigger() stop operation.

-  .. code-block:: c
+.. code-block:: c

   int sdw_disable_stream(struct sdw_stream_runtime * stream);

@@ -357,7 +357,7 @@ Bus implements below API for DEPREPARED state which ne=
eds to be called once
 per stream. From ASoC DPCM framework, this stream state is linked to
 .trigger() stop operation.

-  .. code-block:: c
+.. code-block:: c

   int sdw_deprepare_stream(struct sdw_stream_runtime * stream);

@@ -382,7 +382,7 @@ Bus implements below APIs for RELEASE state which need=
s to be called by
 all the Master(s) and Slave(s) associated with stream. From ASoC DPCM
 framework, this stream state is linked to .hw_free() operation.

-  .. code-block:: c
+.. code-block:: c

   int sdw_stream_remove_master(struct sdw_bus * bus,
 		struct sdw_stream_runtime * stream);
@@ -395,7 +395,7 @@ stream assigned as part of ALLOCATED state.

 In .shutdown() the data structure maintaining stream state are freed up.

-  .. code-block:: c
+.. code-block:: c

   void sdw_release_stream(struct sdw_stream_runtime * stream);

=2D-
2.20.1

