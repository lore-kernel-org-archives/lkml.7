Return-Path: <SRS0=brkd=WZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CFDCAC3A59F
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Aug 2019 22:09:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8E2712166E
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Aug 2019 22:09:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="I8UCUlyz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728208AbfH2WJB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Aug 2019 18:09:01 -0400
Received: from bilbo.ozlabs.org ([203.11.71.1]:57489 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726894AbfH2WI7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Aug 2019 18:08:59 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 46KGwT3sZnz9sN4;
        Fri, 30 Aug 2019 08:08:57 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1567116537;
        bh=oPUe3rhwWfvF1Fc/NKExHISV0sg9NTFdljowS30/yU4=;
        h=Date:From:To:Cc:Subject:From;
        b=I8UCUlyzoSKMWbiRUM7ELLymR5u+d8dvmUPwI/+9jwQW5K1snH+51sHdd4ZO9fMd7
         W8VxGyht1DpX1Wej9cgcMiWYLI+7BB+c8JXeja7xFOaIHhcIwkk3CyahQDcAVla5Zy
         PpmpMS850ROUCqzxbzNUA6e8YTaFJQ63UbzPNnNjPlZbQIc49r/njxzt0iBKmxXubu
         GLVdyURJAxwm7Ts869mOZUnc8H4EVy6qrU+t9OVYeofGKioYxoIy1EgiqWx57qq0IN
         z6TbbUsoubA8H8c19JK8VXGytuIZ9Su3I2AWXXcEnILmcssL8EB3mhgfjoM+R/l0/c
         1NoWmuTYE2h6A==
Date:   Fri, 30 Aug 2019 08:08:55 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Dan Williams <dan.j.williams@intel.com>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Jeff Moyer <jmoyer@redhat.com>
Subject: linux-next: Fixes tag needs some work in the nvdimm-fixes tree
Message-ID: <20190830080855.45421fa0@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/UAeGNm_b/xfzh7TQMVd1vfn";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/UAeGNm_b/xfzh7TQMVd1vfn
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

In commit

  dcbce3cd20be ("libnvdimm/pfn: Fix namespace creation on misaligned addres=
ses")

Fixes tag

  Fixes: commit a3619190d62e ("libnvdimm/pfn: stop padding pmem namespaces =
...")

has these problem(s):

  - leading word 'commit' unexpected

--=20
Cheers,
Stephen Rothwell

--Sig_/UAeGNm_b/xfzh7TQMVd1vfn
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAl1oTPcACgkQAVBC80lX
0Gy9vAf9GDiwi3e9tpdAfThtl+X9HQniBcpHXw/DdhhG3sJjiIQWBZy0oqwD54nC
s+9nxcE2L9rn5+/b600p7akh4aocu9Ush/WzLxhj6nW8U2famvLNwdGoY3VYSrWf
/ju/QzbjhncbT4s8k9VND05TTk6JBHuwAvQl8zhN0VhjabQ+gwz5opPUiNWx6fhj
8dGb5oTUp6Zh1unR52lzzkwki9tUTR9H4j9XA/3KGkQaVeFmqjVExo8JrrMn+vMa
S6k+mk1UL16mC4Z2C9pKPkpEdTadsxhT0J506WSStFug2mE4JnGFRjFAlT2/Xs4W
au9G387gytVS3jtXRORsUVr8QXnh6A==
=SEb4
-----END PGP SIGNATURE-----

--Sig_/UAeGNm_b/xfzh7TQMVd1vfn--
