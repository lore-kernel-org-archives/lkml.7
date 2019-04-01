Return-Path: <SRS0=/BGd=SD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A88DC43381
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 17:49:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0429920883
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 17:49:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733193AbfDARtS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Apr 2019 13:49:18 -0400
Received: from anholt.net ([50.246.234.109]:46682 "EHLO anholt.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732958AbfDARtQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Apr 2019 13:49:16 -0400
Received: from localhost (localhost [127.0.0.1])
        by anholt.net (Postfix) with ESMTP id 6CC6010A278C;
        Mon,  1 Apr 2019 10:49:15 -0700 (PDT)
X-Virus-Scanned: Debian amavisd-new at anholt.net
Received: from anholt.net ([127.0.0.1])
        by localhost (kingsolver.anholt.net [127.0.0.1]) (amavisd-new, port 10024)
        with LMTP id 7Zksoe2BN1xC; Mon,  1 Apr 2019 10:49:14 -0700 (PDT)
Received: from eliezer.anholt.net (localhost [127.0.0.1])
        by anholt.net (Postfix) with ESMTP id 5058B10A2230;
        Mon,  1 Apr 2019 10:49:14 -0700 (PDT)
Received: by eliezer.anholt.net (Postfix, from userid 1000)
        id E7AEF2FE33BA; Mon,  1 Apr 2019 10:49:13 -0700 (PDT)
From:   Eric Anholt <eric@anholt.net>
To:     Kangjie Lu <kjlu@umn.edu>, kjlu@umn.edu
Cc:     pakki001@umn.edu, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] gpu: v3d: fix a missing check of pm_runtime_get_sync
In-Reply-To: <20190324231602.2436-1-kjlu@umn.edu>
References: <20190324231602.2436-1-kjlu@umn.edu>
User-Agent: Notmuch/0.22.2+1~gb0bcfaa (http://notmuchmail.org) Emacs/25.2.2 (x86_64-pc-linux-gnu)
Date:   Mon, 01 Apr 2019 10:49:13 -0700
Message-ID: <875zrx1uqu.fsf@anholt.net>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
        micalg=pgp-sha512; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--=-=-=
Content-Type: text/plain

Kangjie Lu <kjlu@umn.edu> writes:

> pm_runtime_get_sync could fail and thus deserves a check.
>
> The patch adds such a check and return its error code upstream
> if it indeed failed.

Applied the review and merged to drm-misc-next.  Thanks!

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE/JuuFDWp9/ZkuCBXtdYpNtH8nugFAlyiTxkACgkQtdYpNtH8
nui3uBAAqb/3t5e/GVeVRDfh53lYalKrc6Eh8MPj75b0g8ezlaMU5jX8l+DpCo5s
T4pC0ie9VSJShvM8JNz/q5djYbkFmYB2eYfFXWdomMA40V/rLMcGOOFTxtjRx/D0
vXb+aLpGzP9+06wf4fq8h/2gFTyjUceF010q9xGq2CMT/qVywlKZmj1vITp7eaS7
RgW8ILzq2u7gj58Zurs9ZTXN8n8xFeH/Wi/TuJ9v1WZYlcAHhffoJAQOiEW2y7RD
FqcHzo73M518aB00PyAjEunvGRNH2Gv54jRVdyTl1qleLuqeY7/bwtxPlb/jlPKr
049DOEO3caE4xmFEGM07cAxqF3t3OEg20ZkT+glOq6vlQz/Ihma8/1fJgcbuWuZt
bF2Xtd4ovaO4p2tVof9J/vRmF8m6hh17//b3CypIPPSa33o1K2twhjXDCgcFaCkJ
BD/knhWN+/0lTTxUoDrdRra5wwsyVI/wu0M8o4Dss9QeVCdNcMVy/AKY6tNvqCgF
kquLcMCFilSY03fQNa34jW75eAX6m+wxnqJHCGVsHmN+maxF7OcH2Qo8JG/PA8CZ
ys4aFCMsh9izzwjJLmngNyK94VzTTbrYFkpQXMv+LEvA/63MlqcRYCkcNkwc9thW
G2AMavqOc/8O2zAeNcPdpoTOsCuZPD/4WzU+1NtOi8mIQeACk8U=
=DgK0
-----END PGP SIGNATURE-----
--=-=-=--
