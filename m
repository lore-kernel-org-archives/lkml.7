Return-Path: <SRS0=imS1=RN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,USER_AGENT_MUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D169C4360F
	for <linux-kernel@archiver.kernel.org>; Sun, 10 Mar 2019 06:51:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5171620657
	for <linux-kernel@archiver.kernel.org>; Sun, 10 Mar 2019 06:51:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1552200675;
	bh=HDxNBiW8SI0DSD9vh2GBMMSswPfZf3pA4tlj9JLPPjw=;
	h=Date:From:To:Cc:Subject:List-ID:From;
	b=xT1pPxTHcwDZe/3suOSUXS9p/czpqRNfqE/0/Wd8kBaCS6cS0H2Dgutqyx29fpmpr
	 6O6Auc3tqF3h3fVlh+2KnXL/UyAtk26XlcOrvjDgohPHQMvQ4KzJKa+VQHZRqiVeX+
	 YIOweUPnTWnHtXiexJ4xAVMX6lGTicwCeLi4zGP0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726340AbfCJGvO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 10 Mar 2019 01:51:14 -0500
Received: from mail.kernel.org ([198.145.29.99]:54884 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725778AbfCJGvN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Mar 2019 01:51:13 -0500
Received: from localhost (unknown [89.248.140.16])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6F28720657;
        Sun, 10 Mar 2019 06:51:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1552200672;
        bh=HDxNBiW8SI0DSD9vh2GBMMSswPfZf3pA4tlj9JLPPjw=;
        h=Date:From:To:Cc:Subject:From;
        b=AUdiEBxF3ZrGy25EONLAo1u96MW/HrC/dHoGMruz3njQT9fRXDr540/DRLPgdA8Qu
         rJUD/XGd796sGKifR8f/X+URNReCbdpU9Lbx9AEitTpJ90tAYJK1/DYcE/JA872Ciz
         OZix23c/P+Szw3vWkscXiXcCwojSle4cPpFVnBbQ=
Date:   Sun, 10 Mar 2019 07:51:10 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        torvalds@linux-foundation.org, stable@vger.kernel.org
Cc:     lwn@lwn.net, Jiri Slaby <jslaby@suse.cz>
Subject: Linux 5.0.1
Message-ID: <20190310065110.GA24816@kroah.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="x+6KMIRAuhnl3hBn"
Content-Disposition: inline
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--x+6KMIRAuhnl3hBn
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

I'm announcing the release of the 5.0.1 kernel.

All users of the 5.0.1 kernel series must upgrade.

The updated 5.0.1.y git tree can be found at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git linux-5.0.1.y
and can be browsed at the normal kernel.org git web browser:
	http://git.kernel.org/?p=linux/kernel/git/stable/linux-stable.git;a=summary

thanks,

greg k-h

------------

 Makefile |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)


--x+6KMIRAuhnl3hBn
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEZH8oZUiU471FcZm+ONu9yGCSaT4FAlyEs9kACgkQONu9yGCS
aT4w1Q//TJtliFGhxYQqRBxzynmURUG82fDh3o3/ayjENTGn26Hpza9Kkbfi+bGw
i5Fbq0wcjb47H9iFu6g9jsGZ8TGLXTksE2FmSVTSQytnfn0yGw1Qhzgw9bc2k2U8
nJrcWzdjiWF0CfWpDeIuLUlsApS71zS7n6/qhbx0oHGic3fGvV/y3/d6zllV8yQk
WPacDxk13R0ZVhctvIzssD6xU28wsOnfBKsNS7A4S1EMxb5EFQRbWX+T7PtkmQWH
d38EVENnrk2vX8SwXVq1jAgGTUeP2+pwLOo/WqN8vd4Zm3UKpE8ULE5WCp+ggPLW
641rlowmRhBjHdUFeQyhtD0MlP/NpgYqKNd36TRowlkPLmseJmy3dqQUMm/mzM9Z
izUK55Dwew9IjWp6jBdx07FELcMRzIf5fd1BKTEVTLDKUGgWm8ajFRYqjKx0yCwV
KNVp8usrIxTiF28EIOleJwy03yJQ47DVq8KCi+/sa9D2i+NAabq/e49Hq16QmZU2
hyBP7IUjEbT1zVhe6COf13z5lbxuqwAYcMePy4iPbkP303dDTXHFJDL2O0iHS6u6
0J61uaahqW8maQ4JDYGpXVCeNwJVcAhqeqSMmyc26yYF30KRZO/6Vu5Th1b/GFQo
LakulYIentB9GAHWPqP2aZdCOEV6ChLNXKW973B86Wn4rh3rHgI=
=wuBd
-----END PGP SIGNATURE-----

--x+6KMIRAuhnl3hBn--
