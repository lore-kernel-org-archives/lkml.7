Return-Path: <SRS0=pEez=U2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 212CBC48BD3
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Jun 2019 00:52:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E8CDD20663
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Jun 2019 00:52:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1561596777;
	bh=BYIgDo5cCQfVbW8i8SCiF93UcvF7GAgQK8hJSiVY1Pw=;
	h=Date:From:To:Cc:Subject:List-ID:From;
	b=pHtxz8zRFLJNbI2zzHkTfpsAgDi2f7xs6ex6aUHZy7aAhn3VEUIJLFQTI8ycdH/Um
	 zWZ0Tf83cRFRGhSYvmtCQml1tsHLtH1BNyjEfbhnFCFQFrom9SjA3SD7JVJmqBv/ex
	 xhp9S62NnFvvabHNFlk/8ODDrMxBUZI8lrm4pzIE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728023AbfF0Awz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Jun 2019 20:52:55 -0400
Received: from mail.kernel.org ([198.145.29.99]:36956 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726677AbfF0AdH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jun 2019 20:33:07 -0400
Received: from localhost (unknown [116.247.127.123])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 54CA720815;
        Thu, 27 Jun 2019 00:33:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1561595586;
        bh=BYIgDo5cCQfVbW8i8SCiF93UcvF7GAgQK8hJSiVY1Pw=;
        h=Date:From:To:Cc:Subject:From;
        b=UKR9fga2AyvPfhC/HcY5tQ9OfEZgh49y/uA/hFNK11Ycr7leM0/RIlLw476KK1vUA
         F5tLTVNab0cCaeeBfDHNB2GxVlWh1ILzLGlyP2YpSZwmMhtyjrTq6gchy+AgUn+9v/
         +iCVQLv15TT1vvyvIGNgI+jwucBrfCho5zqlZamc=
Date:   Thu, 27 Jun 2019 08:32:45 +0800
From:   Greg KH <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        torvalds@linux-foundation.org, stable@vger.kernel.org
Cc:     lwn@lwn.net, Jiri Slaby <jslaby@suse.cz>
Subject: Linux 4.9.184
Message-ID: <20190627003245.GA10794@kroah.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="7AUc2qLy4jB3hD7Z"
Content-Disposition: inline
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--7AUc2qLy4jB3hD7Z
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

I'm announcing the release of the 4.9.184 kernel.

All users of the 4.9 kernel series must upgrade.

The updated 4.9.y git tree can be found at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git linux-4.9.y
and can be browsed at the normal kernel.org git web browser:
	https://git.kernel.org/?p=linux/kernel/git/stable/linux-stable.git;a=summary

thanks,

greg k-h

------------

 Makefile              |    2 +-
 net/ipv4/tcp_output.c |    2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

Eric Dumazet (1):
      tcp: refine memory limit test in tcp_fragment()

Greg Kroah-Hartman (1):
      Linux 4.9.184


--7AUc2qLy4jB3hD7Z
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEZH8oZUiU471FcZm+ONu9yGCSaT4FAl0UDq0ACgkQONu9yGCS
aT7/HQ//bva1g4CLqwPsqe3ant+SeUHTPIfsLzvsqw8Ec4N1esX9ImJ+sxlRp174
Wm6/DMR41vs4eoECm0EOIuEV1mn3bXxWYmiUj/HuZHRlFZw9CjiqKwU34QVRf282
pw2H8eTTQBR7YZZkgwirZilitHpliWNfFB6lMIRYlS/oba8xUmfiDF0bjFAPBcZM
/LUxFpeNXQgFyvfJ2KVD9N6daxkU2HOvjvGSFgzDrrsb1Tm7CPM05i5z0T8UEO2E
nrBJCZbtdLAstKjlkDZffhcqchny+5Y5qE8tRda6ZtYX8NSj1JitP7fnBowy7ffL
QZwbtC8NqIz82pt3ItguW4Qi9cYfE6M1ZEa1dz/XHEBBFTAyZrddJTYgKs/Kyy1+
HIHmm2Oco65ymT5c6E1jl3Lp0r34n43kiHzmlMNPfh2WadgiQ7zVyNTFofaydXdm
q6/Qd8S4G/DMoPbZSxJfR/1PNIrdCQ6NQBFzje0c/8g8tL3t7CmMnYX9MfDsWNMc
Ke+VBUo28tqhcEnk56Hta6SzvHqRIvfBfC469uZTSyHCUNwJTZP3B7OHPIp3cLwc
Kqn8k8UGrdjv+6HSqLc4Nce51vjaNdystHtW1Ma3Xf4CCK5GV0jvXxNtlXBtawsr
wXx+vRWN6Z4w78YCyBtJwiUZPKaPrsJ6q3OYUNkk9ZpkKt1SDyo=
=RkZj
-----END PGP SIGNATURE-----

--7AUc2qLy4jB3hD7Z--
